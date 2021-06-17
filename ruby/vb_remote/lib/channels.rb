require_relative 'utils'

module BuildStrips
    include Utils

    attr_accessor :num, :strip, :bus, :this_type
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
        include Make_Accessors
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
            self.make_accessor_bool :mono, :mute
            self.make_accessor_float :gain
        end
    end

    class Strip < Channel
        def initialize(run, index)
            super
            self.make_accessor_bool :solo, :mc, :k,
            :A1, :A2, :A3, :A4, :A5, :B1, :B2, :B3
            self.make_accessor_int :limit
            self.make_accessor_float :comp, :gate
            self.make_accessor_standard :label
        end

        def setter(param, value)
            param.chomp!('=')
            if [false,true].include? value
                value = @run.bool_to_float(value)
            end
            @run.set_parameter("Strip[#{@index}].#{param}", value)
        end

        def getter(param)
            if @run.is_bool.include? param
                val = @run.get_parameter("Strip[#{@index}].#{param}")
                return !val.zero?
            end
            @run.get_parameter("Strip[#{@index}].#{param}")
        end
    end

    class Bus < Channel
        def initialize(run, index)
            super
        end

        def setter(param, value)
            param.chomp!('=')
            if [false,true].include? value
                if @run.is_bool.include? param
                    value = @run.bool_to_float(value)
                end
            end
            @run.set_parameter("Bus[#{@index}].#{param}", value)
        end

        def getter(param)
            if @run.is_bool.include? param
                val = @run.get_parameter("Bus[#{@index}].#{param}")
                return !val.zero?
            end
            @run.get_parameter("Bus[#{@index}].#{param}")
        end

        def eq=(value)
            self.setter("EQ.on", value)
        end

        def eq(value = nil)
            return self.getter("EQ.on") if value.nil?
            self.eq = value
        end
    end
end
