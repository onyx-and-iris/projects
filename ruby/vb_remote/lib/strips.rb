module Strips
    attr_accessor :is_numeric, :is_bool, :is_float
    attr_reader :layout, :strip_total, :bus_total, :vban_total, \
    :composite_total, :insert_total

    BASIC = 1
    BANANA = 2
    POTATO = 3

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

    def build_strips(type)
        """ blueprint strip layouts for each type """
        if type == BASIC
            blueprint({
                :strip => {:p_in => 2, :v_in=> 1},
                :bus => {:p_out => 2, :v_out=> 0},
                :in_vban => 4, :out_vban => 4,
                :patch_insert => 0,
                :composite => 0
            })
        elsif type == BANANA
            blueprint({
                :strip => {:p_in => 3, :v_in=> 2},
                :bus => {:p_out => 3, :v_out=> 2},
                :in_vban => 8, :out_vban => 8,
                :patch_insert => 22,
                :composite => 7
            })
        elsif type == POTATO
            blueprint({
                :strip => {:p_in => 5, :v_in=> 3},
                :bus => {:p_out => 5, :v_out=> 3},
                :in_vban => 8, :out_vban => 8,
                :patch_insert => 35,
                :composite => 7
            })
        end
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

        types
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
        end
    end

    def types
        @is_bool = [
            "mono", "solo", "mute",
            "A1", "A2", "A3", "B1", "B2", "B3",
            "macrobutton"
        ]

        @is_float = ["gain"]

        self.is_real_number = @is_bool.|(@is_float)
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

    def type_return(param, value)
        return value.to_i if @is_bool.include? param
        return value.round(1) if @is_float.include? param
        value
    end
end
