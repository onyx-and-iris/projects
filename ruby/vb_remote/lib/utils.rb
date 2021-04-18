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

    def shiftdn(oldnum)
        oldnum - 1
    end

    def shiftup(oldnum)
        oldnum + 1
    end

    def bool_to_float(value)
        (value ? 1 : 0).to_f
    end

    def bool_to_int(value)
        (value ? 1 : 0)
    end

    def type_return(param, value)
        return value.to_i if @is_bool.include? param
        return value.round(1) if @is_float.include? param
        value
    end

    def validate(name, num)
        """
        Validate boundaries unless param requires none
        """
        if name == "strip"
            return num < @strip_total
        elsif name == "bus"
            return num < @bus_total
        elsif name == "instream" || name == "outstream"
            return num < @vban_total
        elsif name == "composite"
            return num < @composite_total
        elsif name == "insert"
            return (num < @insert_total) if @type == POTATO
            raise VersionError
        elsif name == "reverb" || name == "delay"
            return @type == POTATO
            raise VersionError
        elsif @is_bool.include? name
            return [0,1].include? num
        elsif name == "gain"
            return num.between?(-60, 12)
        elsif name == "comp" || name == "gate"
            return num.between?(0, 10)
        elsif name == "limit"
            return num.between?(-40, 12)
        elsif @vban_ranges.has_key? name
            return num.between?(*@vban_ranges[name])
        end
        true
    end
end
