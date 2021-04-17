require 'open3'

require_relative 'base'
require_relative 'strips'
require_relative 'alias'

class Routines
    """ 
    define basic behaviours of API functions
    mixin modules
    """
    include FunctionHooks
    include BuildStrips
    include Alias

    attr_accessor :val, :param_cache, :base_0
    attr_reader :ret, :type, :logged_in, :logged_out, :sp_command, :sp_value,
    :param_string, :param_options, :param_float, :param_name, :instdir

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
        puts "ERROR: #{error.message} #{value} in #{caller_locations[1].label}"
        raise
    end

    def logged_in=(value)
        """ 
        login success status 
        1: OK but Voicemeeter Application not launched.
        -1: cannot get client (unexpected)
        -2: unexpected login (logout was expected before).
        """
        if value == 1
            runvb
        elsif value < 0
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
        raise
    end

    def logged_out=(value)
        if value&.nonzero?
            raise LogoutError
        end
        @logged_out = value
    rescue LogoutError => error
        puts "ERROR: #{error.message}"
        raise
    end

    def type=(value)
        """ vb type """
        unless (1..3).include? value
            raise VBTypeError
        end
        @type = value    
    rescue VBTypeError => error
        puts "ERROR: #{error.message}"
        raise
    end

    def sp_command=(value)
        unless ['Shutdown', 'Show', 'Restart',
            'DialogShow.VBANCHAT', 'Eject',
            'Reset', 'Save', 'Load'].include? value
            raise CommandError
        end
        @sp_command = "Command.#{value}"

    rescue CommandError => error
        puts "ERROR: #{error.message} in #{__callee__}"
        raise
    end

    def sp_value=(value)
        unless value.is_a? (String)
            raise ValueTypeError
        end
        @sp_value = value
    rescue ValueTypeError => error
        puts "ERROR: #{error.message} in #{__callee__}"
        raise
    end

    def param_cache=(*args)
        type, *remaining = args[0]
        if type == "macros"
            logical_id, mode, state = *remaining
            @param_cache["mb_#{logical_id}_#{mode}"] = state           
        elsif type == "params"
            param, value = *remaining
            @param_cache[param] = value
        end
    end

    def param_name=(value)
        """ 
        Test against available regex
        If no matches continue with assignment but there
        will be no boundary testing
        """
        if test_regex(/^(\w+)\[(\d+)\].(\w+)/, value)
        elsif test_regex(/^vban.(\w+)\[(\d+)\].(\w+)/, value)
        elsif test_regex(/^Fx.(\w+).On/, value)
        elsif test_regex(/^patch.(\w+)\[(\d+)\]/, value)
        end

        @param_name = value
    end

    def param_value=(value)
        if value.is_a? (String)
            @param_string = value
        else
            if validate(@m3, value)
                @param_float = value
            else
                raise ParamValueError 
            end
        end
    rescue ParamValueError => error
        puts "ERROR: #{error.message}"
        raise
    end

    def param_options=(value)
        """ Test options against regex then build param string """
        build_str = []
        value.each do |key, val|
            test_regex(/(\w+)_(\d+)/, key)
            name = @m1
            num = shiftdn(@m2)

            val.each do |k, v|
                v = bool_to_int(v) if [false,true].include? v

                if validate(name, num)
                    build_str.append(
                        "#{name.capitalize}[#{num.to_s}].#{k} = #{v}"
                    )
                    self.param_cache = 
                    ["params", "#{name.capitalize}[#{num.to_s}].#{k}", v]
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

    def base_0=(value)
        @base_0 = value
    end

    def initialize(type = nil, base_0 = false)
        self.base_0 = base_0

        if type
            if type == "basic" || type == 1
                self.type = BASIC
            elsif type == "banana" || type == 2
                self.type = BANANA
            elsif type == "potato" || type == 3
                self.type = POTATO
            else
                raise VBTypeError
            end
            build_strips(@type)
            create_alias
        end

        @param_cache = Hash.new
    end

    def runvb
        self.inst_exe = @type
        Open3.popen3(@inst_exe, '')
        sleep(1)
    rescue EXENotFoundError => error
        puts "ERROR: #{error.message}"
    end

    def vbtype
        """ 1 = basic, 2 = banana, 3 = potato """
        c_get = FFI::MemoryPointer.new(:long, SIZE)

        self.ret = run_as(__method__, c_get)
        c_get.read_long
    end
	
    def login
        self.logged_in = run_as(__method__)
        if @type.nil?
            self.type = self.vbtype
            build_strips(@type)
            create_alias
        end
    end

    def logout
        self.logged_out = run_as(__method__)
    end

    def macro_setstatus(logical_id, state, mode=2)
        """ 
        set macrobutton by number, state and mode
        """
        self.logical_id = logical_id
        self.ret = run_as(__method__, @logical_id, state.to_f, mode)
        self.param_cache = ["macros", logical_id, mode, state]

    rescue BoundsError => error
        puts "ERROR: Macrobutton ID out of range in #{__callee__}"
        raise
    end

    def macro_getstatus(logical_id, mode=2)
        if vmr_mdirty
            clear_mdirty
            if @param_cache.key?("mb_#{logical_id}_#{mode}")
                return @param_cache["mb_#{logical_id}_#{mode}"]
            end
        end

        c_get = FFI::MemoryPointer.new(:float, SIZE)
        self.logical_id = logical_id
        self.ret = run_as(__method__, @logical_id, c_get, mode)
        @val = type_return("macrobutton", c_get.read_float)

    rescue BoundsError => error
        puts "ERROR: Logical ID out of range"
        raise
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
                self.ret = 
                run_as("#{__method__}_string", @param_name, @param_string)
                self.param_cache = ["params", @param_name, @param_string]
            else
                self.ret = 
                run_as("#{__method__}_float", @param_name, @param_float)
                self.param_cache = ["params", @param_name, @param_float]
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
        self.param_options = param_hash
        self.ret = run_as(__method__, @param_options)
    end

    def get_parameter(name)
        self.param_name = name
        if vmr_pdirty
            clear_pdirty
            if @param_cache.key?(@param_name)
                if @is_real_number.include? @m3
                    return type_return(@m3, @param_cache[@param_name])
                else
                    return @param_cache[@param_name]
                end
            end
        end

        if @is_real_number.include? @m3
            c_get = FFI::MemoryPointer.new(:float, SIZE)
            self.ret = run_as("#{__method__}_float", @param_name, c_get)
            @val = type_return(@m3, c_get.read_float)
        else
            c_get = FFI::MemoryPointer.new(:string, BUFF, true)
            self.ret = run_as("#{__method__}_string", @param_name, c_get)
            @val = c_get.read_string
        end
    end
end

class Remote < Routines
    """ 
    subclass to BaseRoutines.
    Performs log in/out routines cleanly. 
    May yield a block argument otherwise simply login.
    """
    def initialize(type = nil, **opts)
        super(type, opts[:base_0])
        self.run if opts[:logmein]

    rescue VBTypeError => error
        puts "ERROR: #{error.message}"
        raise
    end

    def run
        login

        if block_given?
            yield

            logout
        end
    end
end
