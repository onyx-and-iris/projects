require_relative 'wrapper'

class BaseRoutines
    """ define basic behaviours of hook functions """
    include VMR_API
    attr_accessor :type
    attr_reader :ret, :success, :sp_command, :value_string, :param_options

    SIZE = 1
    BASIC = 1
    BANANA = 2
    POTATO = 3
    BUFF = 512

    """ Validation writer methods """
    def ret=(value)
        """ C API return value """
        if ret&.nonzero?
            raise "ERROR: CBF failed: #{value}"
        end
        @ret = value
    end

    def success=(value)
        """ login success status """
        if value&.nonzero?
            raise "Voicemeeter not running.. exiting"
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
        regex = /(\w+)_(\d)/

        value.each do |key, val|
            m = regex.match(key)

            k = nil
            v = nil
            val.each do |k, v|
                build_str.append("#{m[1].capitalize}[#{m[2]}].#{k} = #{v}")
            end
        end
        @param_options =  build_str.join(";")
    end

    def get_vbtype
        """ 1 = basic, 2 = banana, 3 = potato """
        c_get = FFI::MemoryPointer.new(:int, SIZE)
        get_type(c_get)
        
        c_get.read_long
    end

    def do_login
        """ login, get type, poll dirty """
        self.success = login

        self.type = get_vbtype
    end

    def do_logout
        logout
    end

    def macro_status(logical_id, state, mode=2)
        """ 
        set macrobutton by number, state and mode
        poll m_dirty to signify value change
        """
        c_get = FFI::MemoryPointer.new(:float, SIZE)

        self.ret = macro_setstatus(logical_id, state.to_f, mode)

        wait_mdirty

        self.ret = macro_getstatus(logical_id, c_get, mode)
        val = c_get.read_float
        val = 1 - val.to_i
    end

    def set_parameter(name, value)
        """ 
        set parameter by name, value
        poll macro_isdirty until nonzero to signify status change
        """
        c_get = FFI::MemoryPointer.new(:float, SIZE)

        self.ret = set_paramfloat(name, value.to_f)
        wait_pdirty

        self.ret = get_paramfloat(name, c_get)
        val = c_get.read_float
        val = 1 - val.to_i
    end

    def set_parameter_string(name, value)
        self.value_string = value

        self.ret = set_paramstring(name, @value_string)
    end

    def set_parameter_multi(param_hash)
        self.param_options = param_hash

        clear_pdirty
        self.ret = set_parammulti(@param_options)
        wait_pdirty
    end

    def get_parameter(name)
        c_get = FFI::MemoryPointer.new(:float, SIZE)

        if param_isdirty&.nonzero?
            clear_pdirty
        end
        self.ret = get_paramfloat(name, c_get)
        val = c_get.read_float
        val.round(1)
    end

    def get_parameter_string(param)
        """ implicity return from pointer variable """
        c_get = FFI::MemoryPointer.new(:string, BUFF, true)

        self.ret = get_paramstring(param, c_get)
        c_get.read_string
    end

    def special_command(name)
        """ Write only commands """
        self.sp_command = name

        self.ret = set_paramfloat("Command.#{@sp_command}", 1.0)
    end

    def recorder_command(name, value=1)
        command = "recorder.#{name}"
        self.ret = set_paramfloat(command, value.to_f)
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