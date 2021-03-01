require_relative 'base'

class BaseRoutines
    """ 
    define basic behaviours of API functions
    mixin modules
    """
    include VMR_API
    include STRIPS
    include UTILS

    attr_accessor :type
    attr_reader :ret, :success, :sp_command, :param_string, :param_options, \
    :param_float, :param_name

    SIZE = 1
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

    def param_name=(value)
        """ 
        Test against available regex
        If no matches continue with assignment but there
        will be no boundary testing
        """
        if test_regex(/^(\w+)\[(\d+)\]/, value)
        elsif test_regex(/^vban.(\w+)\[(\d+)\]/, value)
        elsif test_regex(/^Fx.(\w+).On/, value)
        elsif test_regex(/^patch.(\w+)\[(\d+)\]/, value)
        end

        @param_name = value
    end

    def param_value=(value)
        if value.is_a? (String)
            @param_string = value
        else
            @param_float = value
        end
    end

    def param_options=(value)
        """ Test options against regex then build param string """
        build_str = []

        value.each do |key, val|
            test_regex(/(\w+)_(\d+)/, key)

            name = @m[1]
            num = shift(@m[2])
            k = nil
            v = nil
            val.each do |k, v|
                if validate(name, num)
                    build_str.append(
                        "#{name.capitalize}[#{num}].#{k} = #{v}"
                        )
                end
            end
        end
        @param_options =  build_str.join(";")
    end

    def logical_id=(value)
        if value < 0 || value > 69
            raise "Error: Logical ID out of range"
        end
        @logical_id = value
    end

    def get_vbtype
        """ 1 = basic, 2 = banana, 3 = potato """
        c_get = FFI::MemoryPointer.new(:long, SIZE)
        self.ret = get_type(c_get)
        
        c_get.read_long
    end

    def do_login
        """ login, return vb type, build strip layouts """
        self.success = login

        if param_isdirty&.nonzero?
            clear_pdirty
        end

        self.type = get_vbtype

        build_strips(@type)
    end

    def do_logout
        logout
    end

    def macro_setstatus(logical_id, state, mode=2)
        """ 
        set macrobutton by number, state and mode
        poll m_dirty to signify value change
        """
        self.logical_id = logical_id
        self.ret = macrobutton_setstatus(@logical_id, state.to_f, mode)
        sleep(DELAY)        
    end

    def macro_getstatus(logical_id, mode=2)
        c_get = FFI::MemoryPointer.new(:float, SIZE)

        if macro_isdirty
            clear_mdirty
        end
        self.ret = macrobutton_getstatus(logical_id, c_get, mode)
        val = c_get.read_float
    end

    def set_parameter(name, value)
        """ 
        determine if string or float parameter
        then set parameter by name, value
        """
        self.param_name = name
        self.param_value = value

        begin
            if validate(@m[1].downcase, @m[2])
                if @param_value.is_a? (String)
                    self.ret = set_paramstring(@param_name, @param_string)
                else
                    c_get = FFI::MemoryPointer.new(:float, SIZE)
                    self.ret = set_paramfloat(@param_name, @param_float)
                end
                sleep(DELAY)
            else
                puts "Parameter out of bounds"
            end
        rescue NoMethodError
            raise "Boundary params not defined"
        end
    end

    def set_parameter_multi(param_hash)
        self.param_options = param_hash

        self.ret = set_parammulti(@param_options)
        sleep(DELAY)
    end

    def get_parameter(name)
        c_get = FFI::MemoryPointer.new(:float, SIZE)
        if param_isdirty&.nonzero?
            clear_pdirty
        end

        self.ret = get_paramfloat(name, c_get)
        val = c_get.read_float.round(1)
    end

    def get_parameter_string(name)
        """ implicity return from pointer variable """
        c_get = FFI::MemoryPointer.new(:string, BUFF, true)
        if param_isdirty&.nonzero?
            clear_pdirty
        end

        self.ret = get_paramstring(name, c_get)
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
    subclass to BaseRoutines. 
    Performs log in/out routines cleanly. Yields a block argument
    """
    def run
        do_login
        
        yield

        do_logout
    end
end