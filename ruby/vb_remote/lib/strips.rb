module BuildStrips
    attr_accessor :is_real_number, :is_bool, :is_float, :num, :strip, :bus, 
    :this_type
    attr_reader :layout, :strip_total, :bus_total, :vban_total, \
    :composite_total, :insert_total

    ON = 1
    OFF = 0

    def layout=(value)
        @layout = value
    end

    def strip_total=(value)
        @strip_total = value
    end

    def bus_total=(value)
        @bus_total = value
    end

    def vban_total=(value)
        @vban_total = value
    end

    def composite_total=(value)
        @composite_total = value
    end

    def insert_total=(value)
        @insert_total = value
    end

    def is_real_number=(value)
        @is_real_number = value
    end

    def strip=(value)
        @strip = value 
    end

    def bus=(value)
        @bus = value
    end

    def build_strips(type)
        """ blueprint strip layouts for each type """
        @this_type = type
        if @this_type == BASIC
            blueprint({
                :strip => {:p_in => 2, :v_in=> 1},
                :bus => {:p_out => 2, :v_out=> 0},
                :in_vban => 4, :out_vban => 4,
                :patch_insert => 0,
                :composite => 0
            })
        elsif @this_type == BANANA
            blueprint({
                :strip => {:p_in => 3, :v_in=> 2},
                :bus => {:p_out => 3, :v_out=> 2},
                :in_vban => 8, :out_vban => 8,
                :patch_insert => 22,
                :composite => 7
            })
        elsif @this_type == POTATO
            blueprint({
                :strip => {:p_in => 5, :v_in=> 3},
                :bus => {:p_out => 5, :v_out=> 3},
                :in_vban => 8, :out_vban => 8,
                :patch_insert => 35,
                :composite => 7
            })
        end

        strip_factory
        bus_factory
    end

    def blueprint(opts)
        self.layout = opts

        self.vban_total = @layout[:in_vban]
        self.composite_total = @layout[:composite]
        self.insert_total = @layout[:patch_insert]

        self.strip_total = 
        @layout[:strip][:p_in].+(@layout[:strip][:v_in])
        self.bus_total = 
        @layout[:bus][:p_out].+(@layout[:bus][:v_out])

        define_types
    end

    def validate(name, num)
        """ 
        Validate boundaries unless param requires none
        """
        if name == "strip"
            num < @strip_total
        elsif name == "bus"
            num < @bus_total
        elsif name == "instream" || name == "outstream"
            num < @vban_total
        elsif name == "composite" 
            num < @composite_total
        elsif name == "insert"
            return (num < @insert_total) if @type == POTATO
            raise VersionError
        elsif name == "reverb" || name == "delay"
            return true if @type == POTATO
            raise VersionError
        elsif @is_bool.include? name
            return num == 0 || num == 1
        elsif name == "gain"
            return num.between?(-60, 12)
        end
    end

    def define_types
        @is_bool = [
            "mono", "solo", "mute", "mc", "k",
            "A1", "A2", "A3", "B1", "B2", "B3",
            "macrobutton", "vban"
        ]

        @is_float = ["gain"]

        self.is_real_number = @is_bool.|(@is_float)
    end

    def strip_factory
        self.strip = []
        (0..@strip_total).each_with_index do |num, index|
            @strip[num] = Strip.new(self, index, @this_type)
        end
    end

    def bus_factory
        self.bus = []
        (0..@bus_total).each_with_index do |num, index|
            @bus[num] = Bus.new(self, index, @this_type)
        end
    end

    class Strip
        attr_accessor :index, :this_type, :run

        def index=(value)
            @index = value
        end

        def this_type=(value)
            @this_type = value
        end

        def initialize(run, index, type)
            @run = run
            self.index = shift(index)
            self.this_type = type
        end

        def shift(oldnum)
            oldnum - 1
        end

        def set(param, value)
            @run.set_parameter(param, value)
        end

        def get(param)
            @run.get_parameter(param)
        end

        def mute=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def mute
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def solo=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def solo
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def mono=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def mono
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def mc=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def mc
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def k=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def k
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def gain=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def gain
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def A1=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def A1
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def A2=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def A2
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def A3=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def A3
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def A4=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def A4
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def A5=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def A5
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def B1=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end
        
        def B1
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def B2=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def B2
            get("Strip[#{@index}].#{__method__.to_s}")
        end

        def B3=(value)
            set("Strip[#{@index}].#{__method__.to_s}", value)
        end

        def B3
            get("Strip[#{@index}].#{__method__.to_s}")
        end
    end

    class Bus
        attr_accessor :index, :this_type

        def index=(value)
            @index = value
        end

        def this_type=(value)
            @this_type = value
        end

        def initialize(run, index, type)
            @run = run
            self.index = shift(index)
            self.this_type = type
        end

        def set(param, value)
            @run.set_parameter(param, value)
        end

        def get(param)
            return @run.get_parameter(param)
        end

        def shift(oldnum)
            oldnum - 1
        end

        def mute=(value)
            set("Bus[#{@index}].#{__method__.to_s}", value)
        end

        def mute
            get("Bus[#{@index}].#{__method__.to_s}")
        end

        def solo=(value)
            set("Bus[#{@index}].#{__method__.to_s}", value)
        end

        def solo
            get("Bus[#{@index}].#{__method__.to_s}")
        end
        
        def mono=(value)
            set("Bus[#{@index}].#{__method__.to_s}", value)
        end

        def mono
            get("Bus[#{@index}].#{__method__.to_s}")
        end

        def gain=(value)
            set("Bus[#{@index}].#{__method__.to_s}", value)
        end

        def gain
            get("Bus[#{@index}].#{__method__.to_s}")
        end
    end
end

module Utils
    attr_reader :m1, :m2, :m3

    def m1=(value)
        @m1 = value.downcase
    end

    def m2=(value)
        @m2 = value.to_i
    end

    def m3=(value)
        @m3 = value
    end

    def test_regex(regex, param)
        regex.match(param) do |m|
            self.m1 = m[1]
            self.m2 = m[2]
            self.m3 = m[3]
        end
    end

    def shift(oldnum)
        oldnum - 1
    end

    def bool_to_float(param, value)
        value = (value ? 1 : 0).to_f
    end

    def type_return(param, value)
        return value.to_i if @is_bool.include? param
        return value.round(1) if @is_float.include? param
        value
    end
end
