require 'ffi'

module VMR_API
    """ import dll and register hooks to C API """
    dll = ['C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll']
    extend FFI::Library

    ffi_lib dll
    ffi_convention :stdcall

    attach_function :login, :VBVMR_Login, [], :long
    attach_function :logout, :VBVMR_Logout, [], :long
    attach_function :run, :VBVMR_RunVoicemeeter, [:int], :long
    attach_function :get_type, :VBVMR_GetVoicemeeterType, [:pointer], :long

    attach_function :macro_isdirty, :VBVMR_MacroButton_IsDirty, [], :long
    attach_function :macro_setstatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long
    attach_function :macro_getstatus, :VBVMR_MacroButton_GetStatus, \
    [:long, :pointer, :long], :long

    attach_function :param_isdirty, :VBVMR_IsParametersDirty, [], :long
    attach_function :set_paramfloat, :VBVMR_SetParameterFloat, \
    [:string, :float], :long
    attach_function :get_paramfloat, :VBVMR_GetParameterFloat, \
    [:string, :pointer], :long

    attach_function :set_paramstring, :VBVMR_SetParameterStringA, \
    [:string, :string], :long
    attach_function :get_paramstring, :VBVMR_GetParameterStringA, \
    [:string, :pointer], :long

    attach_function :set_parammulti, :VBVMR_SetParameters, \
    [:string], :long
end

class BaseRoutines
    """ define basic behaviours of hook functions """
    include VMR_API
    attr_accessor :type, :param_cache
    attr_reader :success, :ret, :sp_command, :value_string, :param_options

    SIZE = 1
    POS = 0
    BASIC = 1
    BANANA = 2
    POTATO = 3
    BUFF = 512

    """ Validation writer methods """
    def success=(value)
        """ login success status """
        if value&.nonzero?
            raise "Voicemeeter not running.. exiting"
            logout
        end
        @success = value
    end

    def type=(value)
        """ vb type """
        unless (1..3).include? value
            raise "Invalid vb type"
        end
        @type = value
    end

    def ret=(value)
        """ C API return value """
        if ret&.nonzero?
            raise "ERROR: CBF failed: #{value}"
        end
        @ret = value
    end

    def sp_command=(value)
        unless ['Shutdown', 'Show', 'Restart', -
            'Reset', 'DialogShow.VBANCHAT'].include? value
            raise "Error: Command not supported"
        end
        @sp_command = value
    end

    def value_string=(value)
        if value.length > 512
            raise "Error: string too long"
        end
        @value_string = value
    end

    def param_options=(value)
        """ Add test against factory functions """
        build_str = []

        value.each do |key, val|
            com = /strip_\d/.match(key).to_s.split('_')[0]
            num = /strip_\d/.match(key).to_s.split('_')[1]

            k = nil
            v = nil
            val.each do |k, v|
                build_str.append("#{com.capitalize}[#{num}].#{k} = #{v}")
            end
        end
        @param_options =  build_str.join(";")
    end

    def get_vbtype
        """ 1 = basic, 2 = banana, 3 = potato """
        c_get = FFI::MemoryPointer.new(:int, SIZE)
        get_type(c_get)
        
        c_get.get_long(POS)
    end

    def clear_pdirty
        while param_isdirty&.nonzero?
        end
    end

    def wait_mdirty
        until macro_isdirty&.nonzero?
        end
    end

    def do_login
        """ login, get type, poll dirty """
        self.success = login

        self.type = get_vbtype

        clear_pdirty
    end

    def do_logout
        logout
    end

    def macro_status(logical_id, state, mode=2)
        """ 
        set macrobutton by number, state and mode
        poll macro_isdirty until nonzero to signify status change
        """
        c_get = FFI::MemoryPointer.new(:float, SIZE)
        macro_getstatus(logical_id, c_get, mode)
        oldval = c_get.get_float(POS)

        self.ret = macro_setstatus(logical_id, state.to_f, mode)

        wait_mdirty

        self.ret = macro_getstatus(logical_id, c_get, mode)
        newval = c_get.get_float(POS)
        newval = 1 - newval.to_i
    end

    def set_parameter(name, value)
        """ 
        set parameter by name, value
        poll macro_isdirty until nonzero to signify status change
        """
        c_get = FFI::MemoryPointer.new(:float, SIZE)

        self.ret = set_paramfloat(name, value.to_f)

        clear_pdirty

        self.ret = get_paramfloat(name, c_get)
        newval = c_get.get_float(POS)
        newval = 1 - newval.to_i
        puts newval
    end

    def set_parameter_string(name, value)
        self.value_string = value
        c_set = FFI::MemoryPointer.new(:string, @value_string.length)
        c_set.put_string(POS, @value_string)

        newname =  c_set.get_string(POS)
        puts newname

        self.ret = set_paramstring(name, newname)
    end

    def set_parameter_multi(param_hash)
        self.param_options = param_hash
        self.param_cache = param_hash
        
        self.ret = set_parammulti(@param_options)
    end

    def get_parameter_string(param)
        c_get = FFI::MemoryPointer.new(:string, BUFF, true)

        self.ret = get_paramstring(param, c_get)
        puts(c_get.read_string)
    end

    def special_command(name)
        """ Write only commands """
        self.sp_command = name

        self.ret = set_paramfloat("Command.#{@sp_command}", 1.0)
    end

    def recorder_command(name, value=1)
        command = "recorder.#{name}"
        value = value.to_f
        self.ret = set_paramfloat(command, value)
    end
end

class Remote < BaseRoutines
    """ 
    subclass to Routines. Performs log in/out routines cleanly. 
    """
    def run
        do_login
        puts "Logged in"

        is_type = get_vbtype
        print "Running Voicemeeter version: "
        if is_type == BASIC
            puts "Basic"
        elsif is_type == BANANA
            puts "Banana"
        elsif is_type == POTATO
            puts "Potato"
        end

        yield

        do_logout
        puts "Logged out"
    end
end