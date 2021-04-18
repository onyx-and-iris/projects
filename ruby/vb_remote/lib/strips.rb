require_relative 'utils'

module BuildStrips
    include Utils

    attr_accessor :is_real_number, :is_bool, :is_float, :num, :strip, :bus,
    :this_type, :vban_ranges
    attr_reader :layout, :strip_total, :bus_total, :vban_total,
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

    def vban_ranges=(value)
        @vban_ranges = value
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
                :bus => {:p_out => 1, :v_out=> 1},
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
                :composite => 8
            })
        elsif @this_type == POTATO
            blueprint({
                :strip => {:p_in => 5, :v_in=> 3},
                :bus => {:p_out => 5, :v_out=> 3},
                :in_vban => 8, :out_vban => 8,
                :patch_insert => 34,
                :composite => 8
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

    def define_types
        @is_bool = [
            "mono", "solo", "mute", "mc", "k",
            "A1", "A2", "A3", "B1", "B2", "B3",
            "EQ.on",
            "macrobutton"
        ]

        @is_float = ["gain", "comp", "gate", "limit"]

        self.is_real_number = @is_bool.|(@is_float)

        self.vban_ranges = {
            "on" => [0,1],
            "port" => [0,65535],
            "sr" => [11025,96000],
            "channel" => [1,8],
            "quality" => [0,4],
            "route" => [0,8]
        }
    end

    def strip_factory
        self.strip = []
        (1..@strip_total).each_with_index do |num, index|
            num = index if @base_0
            @strip[num] = Strip.new(self, index)
        end
    end

    def bus_factory
        self.bus = []
        (1..@bus_total).each_with_index do |num, index|
            num = index if @base_0
            @bus[num] = Bus.new(self, index)
        end
    end

    class Channel
        attr_accessor :run, :index

        def run=(value)
            @run = value
        end

        def index=(value)
            @index = value
        end

        def initialize(run, index)
            self.run = run
            self.index = index
        end

        def mono=(value)
            set(__method__.to_s, value)
        end

        def mono(value = nil)
            return get(__method__.to_s) if value.nil?
            self.mono = value
        end

        def mute=(value)
            set(__method__.to_s, value)
        end

        def mute(value = nil)
            return get(__method__.to_s) if value.nil?
            self.mute = value
        end

        def gain=(value)
            set(__method__.to_s, value)
        end

        def gain(value = nil)
            return get(__method__.to_s) if value.nil?
            self.gain = value
        end
    end

    class Strip < Channel
        def initialize(run, index)
            super
        end

        def set(param, value)
            param.chomp!('=')
            if [false,true].include? value
                value = @run.bool_to_float(value)
            end
            @run.set_parameter("Strip[#{@index}].#{param}", value)
        end

        def get(param)
            if @run.is_bool.include? param
                val = @run.get_parameter("Strip[#{@index}].#{param}")
                return !val.zero?
            end
            @run.get_parameter("Strip[#{@index}].#{param}")
        end

        def solo=(value)
            set(__method__.to_s, value)
        end

        def solo(value = nil)
            return get(__method__.to_s) if value.nil?
            self.solo = value
        end

        def mc=(value)
            set(__method__.to_s, value)
        end

        def mc(value = nil)
            return get(__method__.to_s) if value.nil?
            self.mc = value
        end

        def k=(value)
            set(__method__.to_s, value)
        end

        def k(value = nil)
            return get(__method__.to_s) if value.nil?
            self.k = value
        end

        def comp=(value)
            set(__method__.to_s, value)
        end

        def comp(value = nil)
            return get(__method__.to_s) if value.nil?
            self.comp = value
        end

        def gate=(value)
            set(__method__.to_s, value)
        end

        def gate(value = nil)
            return get(__method__.to_s) if value.nil?
            self.gate = value
        end

        def limit=(value)
            set(__method__.to_s, value)
        end

        def limit(value = nil)
            return get(__method__.to_s) if value.nil?
            self.limit = value
        end

        def A1=(value)
            set(__method__.to_s, value)
        end

        def A1(value = nil)
            return get(__method__.to_s) if value.nil?
            self.A1 = value
        end

        def A2=(value)
            set(__method__.to_s, value)
        end

        def A2(value = nil)
            return get(__method__.to_s) if value.nil?
            self.A2 = value
        end

        def A3=(value)
            set(__method__.to_s, value)
        end

        def A3(value = nil)
            return get(__method__.to_s) if value.nil?
            self.A3 = value
        end

        def A4=(value)
            set(__method__.to_s, value)
        end

        def A4(value = nil)
            return get(__method__.to_s) if value.nil?
            self.A4 = value
        end

        def A5=(value)
            set(__method__.to_s, value)
        end

        def A5(value = nil)
            return get(__method__.to_s) if value.nil?
            self.A5 = value
        end

        def B1=(value)
            set(__method__.to_s, value)
        end

        def B1(value = nil)
            return get(__method__.to_s) if value.nil?
            self.B1 = value
        end

        def B2=(value)
            set(__method__.to_s, value)
        end

        def B2(value = nil)
            return get(__method__.to_s) if value.nil?
            self.B2 = value
        end

        def B3=(value)
            set(__method__.to_s, value)
        end

        def B3(value = nil)
            return get(__method__.to_s) if value.nil?
            self.B3 = value
        end

        def label=(value)
            set(__method__.to_s, value)
        end

        def label(value = nil)
            return get(__method__.to_s) if value.nil?
            self.label = value
        end
    end

    class Bus < Channel
        def initialize(run, index)
            super
        end

        def set(param, value)
            param.chomp!('=')
            if [false,true].include? value
                if @run.is_bool.include? param
                    value = @run.bool_to_float(value)
                end
            end
            @run.set_parameter("Bus[#{@index}].#{param}", value)
        end

        def get(param)
            if @run.is_bool.include? param
                val = @run.get_parameter("Bus[#{@index}].#{param}")
                return !val.zero?
            end
            @run.get_parameter("Bus[#{@index}].#{param}")
        end

        def EQ=(value)
            set("EQ.on", value)
        end

        def EQ(value = nil)
            return get("EQ.on") if value.nil?
            self.EQ = value
        end
    end
end
