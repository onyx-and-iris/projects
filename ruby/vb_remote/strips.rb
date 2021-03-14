module Strips
    attr_reader :layout, :strip_total, :bus_total, :vban_total

    BASIC = 1
    BANANA = 2
    POTATO = 3

    def layout=(value)
        @layout = value
    end

    def strip_total=(value)
        @strip_total = value.to_i
    end

    def bus_total=(value)
        @bus_total = value.to_i
    end

    def vban_total=(value)
        @layout[:in_vban] = value
        @layout[:out_vban] = value
        @vban_total = value
    end

    def composite_total=(value)
        if value < 0 || value > 7
            raise "Value out of bounds"
        end
        @composite_total = value
    end

    def insert_total=(value)
        if value < 0 || value > 33
            raise "Value out of bounds"
        end
        @insert_total = value
    end

    def build_strips(type)
        self.layout =  {
            :strip => {:p_in => 0, :v_in => 0}, 
            :bus => {:p_out => 0, :v_out => 0},
            :in_vban => 0, 
            :out_vban => 0,
            :patch_insert => 0
        }

        if type == BASIC
            factory([2, 1, 2, 0, 4, 0])
        elsif type == BANANA
            factory([3, 2, 3, 2, 8, 22])
        elsif type == POTATO
            factory([5, 3, 5, 3, 8, 33])
        end
    end

    def factory(values)
        num = 0

        @layout.each do |key, val|
            unless @layout[key] && @layout[key][val]
                val.each do |k, v|
                    @layout[key][k] = values[num]
                    num += 1
                end
            end
        end
        self.vban_total = values[num]
        num += 1
        self.composite_total = 7
        self.insert_total = values[num]

        self.strip_total = 
        @layout[:strip][:p_in].to_i.+(@layout[:strip][:v_in].to_i)
        self.bus_total = 
        @layout[:bus][:p_out].to_i.+(@layout[:bus][:v_out].to_i)
    end

    def validate(name, num)
        """ 
        Validate boundaries unless param requires none 
        example: Reverb and Delay, then return true
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
            if @type == POTATO
                num < @insert_total
            else
                raise VersionError
            end
        elsif name == "reverb" || name == "delay"
            if @type == POTATO
            else
                raise VersionError
            end
        end
    end
end

module Utils
    attr_reader :m1, :m2

    def m1=(value)
        @m1 = value.downcase
    end

    def m2=(value)
        @m2 = value.to_i
    end

    def test_regex(regex, param)
        regex.match(param) do |m|
            self.m1 = m[1]
            self.m2 = m[2]
        end
    end

    def shift(oldnum)
        oldnum - 1
    end
end
