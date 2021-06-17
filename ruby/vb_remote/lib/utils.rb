module Utils
    attr_reader :m1, :m2, :m3, :is_bool, :is_int, :is_float,
    :is_real_number, :is_natural_number, :vban_ranges

    def m1=(value)
        @m1 = value.downcase
    end

    def m2=(value)
        if value.to_i.to_s == value
            @m2 = value.to_i
        else
            @m2 = value
        end
    end

    def m3=(value)
        if value.to_i.to_s == value
            @m3 = value
        else
            @m3 = value
        end
    end

    def is_natural_number=(value)
        @is_natural_number = value
    end

    def is_real_number=(value)
        @is_real_number = value
    end

    def vban_ranges=(value)
        @vban_ranges = value
    end

    def test_regex(regex, param)
        regex.match(param) do |m|
            self.m1 = m[1]
            self.m2 = m[2]
            self.m3 = m[3]
            matches = 0
            (1..m.size).each { |num| matches += 1 if m[num] }
            return matches
        end
    end

    def shiftdn(oldnum)
        oldnum.to_i - 1
    end

    def shiftup(oldnum)
        oldnum.to_i + 1
    end

    def bool_to_float(value)
        (value ? 1 : 0).to_f
    end

    def bool_to_int(value)
        (value ? 1 : 0)
    end

    def is_a_bool?(value)
        return !!value == value || [0,1].include?(value)
    end

    def type_return(param, value)
        return value.to_i if @is_natural_number.include? param
        return value.round(1) if @is_float.include? param
        value
    end

    def define_types
        @is_bool = [
            "mono", "solo", "mute", "mc", "k",
            "A1", "A2", "A3", "B1", "B2", "B3",
            "EQ.on",
            "macrobutton",
            "on"
        ]

        @is_int = [
            "sr", "channel", "bit", "quality", "route"
        ]

        @is_float = ["gain", "comp", "gate", "limit"]

        self.is_natural_number = @is_bool.|(@is_int)
        self.is_real_number = @is_float.|(@is_natural_number)

        self.vban_ranges = {
            "on" => [0,1],
            "port" => [0,65535],
            "sr" => [
            11025, 16000, 22050, 24000, 32000, 44100, 48000, 64000, 88200, 96000
            ],
            "channel" => [1,8],
            "quality" => [0,4],
            "route" => [0,8],
            "bit" => [1,2]
        }
    end

    def validate(name, num)
        """
        Validate boundaries unless param requires none
        """
        if name == "strip"
            return num < @strip_total
        elsif name == "bus"
            return num < @bus_total
        elsif name == "mb"
            return num.between?(0, 69)
        elsif ["vban", "instream", "outstream"].include? name
            return num < @vban_total
        elsif name == "composite"
            return num < @composite_total
        elsif name == "insert"
            return (num < @insert_total) if @type == POTATO
            raise BaseErrors::VersionError
        elsif name == "reverb" || name == "delay"
            return @type == POTATO
            raise BaseErrors::VersionError
        elsif @is_bool.include? name
            return [0,1].include? num
        elsif name == "gain"
            return num.between?(-60, 12)
        elsif name == "comp" || name == "gate"
            return num.between?(0, 10)
        elsif name == "limit"
            return num.between?(-40, 12)
        elsif @vban_ranges.has_key? name
            return @vban_ranges[name].include? num if name == "bit" || name == "sr"
            return num.between?(*@vban_ranges[name])
        end
        true
    end
end
