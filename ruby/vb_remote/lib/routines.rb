require_relative 'base'
require_relative 'strips'

class BaseRoutines
    """ 
    define basic behaviours of API functions
    mixin modules
    """
    include WrapperBase
    include Strips
    include Utils

    attr_accessor :type
    attr_reader :ret, :success, :sp_command, :param_string, :param_options, \
    :param_float, :param_name

    SIZE = 1
    BUFF = 512

    """ Validation writer methods """
    def ret=(value)
        """ C API return value """
        if value&.nonzero?
            raise APIError
        end
        @ret = value

    rescue APIError => error
        puts "ERROR: #{error.message} #{value}"
    end

    def success=(value)
        """ login success status """
        if value&.nonzero?
            raise LoginError
        else
            if param_isdirty&.nonzero?
                clear_pdirty
            end
            if macro_isdirty&.nonzero?
                clear_mdirty
            end

            @success = value
        end

    rescue LoginError => error
        puts "ERROR: #{error.message} #{value}"
        do_logout
        exit(false)
    end

    def type=(value)
        """ vb type """
        unless (1..3).include? value
            raise "Invalid vb type"
        end
        @type = value
    end

    def sp_command=(value)
        unless ['Shutdown', 'Show', 'Restart',
            'DialogShow.VBANCHAT', 
            'Reset', 'Save', 'Load'].include? value
            raise ParamComError
        end
        @sp_command = "Command." + value
    end

    def sp_value=(value)
        unless value.is_a? (String)
            raise ParamTypeError
        end
        @sp_value = value
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
            name = @m1
            num = shift(@m2)

            val.each do |k, v|
                if validate(name, num)
                    build_str.append(
                        "#{name.capitalize}[#{num.to_s}].#{k} = #{v}"
                    )
                end
            end
        end
        @param_options =  build_str.join(";")
    end

    def logical_id=(value)
        if value < 0 || value > 69
            raise BoundsError
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

    rescue BoundsError => error
        puts "ERROR: Logical ID out of range" 
    end

    def macro_getstatus(logical_id, mode=2)
        if macro_isdirty
            clear_mdirty
        end

        c_get = FFI::MemoryPointer.new(:float, SIZE)
        self.logical_id = logical_id
        self.ret = macrobutton_getstatus(@logical_id, c_get, mode)
        c_get.read_float

    rescue BoundsError => error
        puts "ERROR: Logical ID out of range"
    end

    def set_parameter(name, value)
        """ 
        determine if string or float parameter
        then set parameter by name, value
        """
        self.param_name = name
        self.param_value = value

        if validate(@m1, @m2)
            if @param_string
                self.ret = set_paramstring(@param_name, @param_string)
            else
                c_get = FFI::MemoryPointer.new(:float, SIZE)
                self.ret = set_paramfloat(@param_name, @param_float)
            end
            sleep(DELAY)
        else
            raise BoundsError
        end
    rescue VersionError => error
        puts "ERROR: #{error.message}"
    rescue BoundsError => error
        puts "ERROR: #{error.message}"
    end

    def set_parameter_multi(param_hash)
        self.param_options = param_hash
        self.ret = set_parammulti(@param_options)
        sleep(DELAY)
    end

    def get_parameter(name)
        if param_isdirty&.nonzero?
            clear_pdirty
        end

        c_get = FFI::MemoryPointer.new(:float, SIZE)
        self.ret = get_paramfloat(name, c_get)
        c_get.read_float.round(1)
    end

    def get_parameter_string(name)
        """ implicity return from pointer variable """
        if param_isdirty&.nonzero?
            clear_pdirty
        end

        c_get = FFI::MemoryPointer.new(:string, BUFF, true)
        self.ret = get_paramstring(name, c_get)
        c_get.read_string
    end

    def special_command(name, value = nil)
        """ Write only commands """
        self.sp_command = name

        if value
            self.sp_value = value
            self.ret = set_paramstring("#{@sp_command}", @sp_value)
        else
            self.ret = set_paramfloat("#{@sp_command}", 1.0)
        end
        sleep(DELAY)

    rescue ParamComError => error
        puts "#{error.message}"
    rescue ParamTypeError => error
        puts "ERROR: #{error.message}"
    end

    def recorder_command(name, value=1)
        command = "recorder.#{name}"
        self.ret = set_paramfloat(command, value.to_f)
        sleep(DELAY)
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
