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

    attr_accessor :val, :testing
    attr_reader :ret, :type, :logged_in, :logged_out, :sp_command, \
    :param_string, :param_options, :param_float, :param_name

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

    def logged_in=(value)
        """ login success status """
        if value&.nonzero?
            raise LoginError
        else
            if vmr_pdirty&.nonzero?
                clear_pdirty
            end
            if vmr_mdirty&.nonzero?
                clear_mdirty
            end

            @logged_in = value
        end

    rescue LoginError => error
        puts "ERROR: #{error.message} #{value}"
        do_logout
        exit(false)
    end

    def logged_out=(value)
        if value&.nonzero?
            raise LogoutError
        end
        @logged_out = value
    rescue LogoutError => error
        puts "ERROR: #{error.message}"
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
        if test_regex(/^(\w+)\[(\d+)\].(\w+)/, value)
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

    def vbtype
        """ 1 = basic, 2 = banana, 3 = potato """
        c_get = FFI::MemoryPointer.new(:long, SIZE)

        self.ret = exec(__method__, c_get)
        c_get.read_long
    end
	
    def login
        self.logged_in = exec(__method__)
        self.type = self.vbtype
        build_strips(@type)
    end

    def logout
        self.logged_out = exec(__method__)
    end

    def macro_setstatus(logical_id, state, mode=2)
        """ 
        set macrobutton by number, state and mode
        poll m_dirty to signify value change
        """
        self.logical_id = logical_id
        self.ret = exec(__method__, @logical_id, state.to_f, mode)

    rescue BoundsError => error
        puts "ERROR: Logical ID out of range"
        raise
    end

    def macro_getstatus(logical_id, mode=2)
        if vmr_mdirty&.nonzero?
            clear_mdirty
        end

        c_get = FFI::MemoryPointer.new(:float, SIZE)
        self.logical_id = logical_id
        self.ret = exec(__method__, @logical_id, c_get, mode)
        @val = type_return("macrobutton", c_get.read_float)

    rescue BoundsError => error
        puts "ERROR: Logical ID out of range"
    end

    def set_parameter(name, value)
        """ 
        determine if string or float parameter
        then set parameter by name, value
        """
        @param_string = nil
        @param_float = nil
        self.param_name = name
        self.param_value = value

        if validate(@m1, @m2)
            if @param_string
                self.ret = exec(__method__.to_s + '_string', @param_name, @param_string)
            else
                self.ret = exec(__method__.to_s + '_float', @param_name, @param_float)
            end
        else
            raise BoundsError
        end
    rescue VersionError => error
        puts "ERROR: #{error.message}"
    rescue BoundsError => error
        puts "ERROR: #{error.message}"
    end

    def set_parameter_multi(param_hash)
        if vmr_pdirty&.nonzero?
            clear_pdirty
        end

        self.param_options = param_hash
        self.ret = exec(__method__, @param_options)

        if vmr_pdirty&.zero?
            wait_pdirty
        end
    end

    def get_parameter(name)
        if vmr_pdirty&.nonzero?
            clear_pdirty
        end
        self.param_name = name

        if @is_real_number.include? @m3
            c_get = FFI::MemoryPointer.new(:float, SIZE)
            self.ret = exec(__method__.to_s + '_float', @param_name, c_get)
            @val = type_return(@m3, c_get.read_float)
        else
            c_get = FFI::MemoryPointer.new(:string, BUFF, true)
            self.ret = exec(__method__.to_s + '_string', @param_name, c_get)
            @val = c_get.read_string
        end
    end

    def special_command(name, value = nil)
        """ Write only commands """
        self.sp_command = name

        if value
            self.sp_value = value
            self.ret = exec('set_parameter_string', "#{@sp_command}", @sp_value)
        else
            self.ret = exec('set_parameter_float', "#{@sp_command}", 1.0)
        end

    rescue ParamComError => error
        puts "ERROR: #{error.message}"
    rescue ParamTypeError => error
        puts "ERROR: #{error.message}"
    end

    def recorder_command(name, value=1)
        command = "recorder.#{name}"
        self.ret = exec('set_parameter_float', command, value.to_f)
        #sleep(DELAY)
    end
end

class Remote < BaseRoutines
    """ 
    subclass to BaseRoutines. 
    Performs log in/out routines cleanly. 
    May yield a block argument otherwise simply login.
    """
    def initialize(opt = nil)
        if opt == "minitest"
            @testing = opt
        end
        self.run if opt
    end

    def run
        login
        
        if block_given?
            yield

            logout
        end
    end
end
