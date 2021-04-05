require_relative '../minitest_helper'

class GetParamsFloat < Minitest::Test
    def test_it_gets_strip_0to1_mono_value_on
        (0..1).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(ON, @@vmr.get_parameter("Strip[#{num}].mono"))
        end
    end

    def test_it_gets_strip_0to1_mono_value_off
        (0..1).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(OFF, @@vmr.get_parameter("Strip[#{num}].mono"))
        end
    end

    def test_it_gets_strip_0to2_solo_value_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(ON, @@vmr.get_parameter("Strip[#{num}].solo"))
        end
    end

    def test_it_gets_strip_0to2_solo_value_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(OFF, @@vmr.get_parameter("Strip[#{num}].solo"))
        end
    end

    def test_it_gets_strip_0to2_mute_value_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(ON, @@vmr.get_parameter("Strip[#{num}].mute"))
        end
    end

    def test_it_gets_strip_0to2_mute_value_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(OFF, @@vmr.get_parameter("Strip[#{num}].mute"))
        end
    end

    def test_it_gets_bus_0to1_mute_value_on
        (0..1).each do |num|
            @@vmr.set_parameter("Bus[#{num}].mute", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(ON, @@vmr.get_parameter("Bus[#{num}].mute"))
        end
    end

    def test_it_gets_bus_0to1_mute_value_off
        (0..1).each do |num|
            @@vmr.set_parameter("Bus[#{num}].mute", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(OFF, @@vmr.get_parameter("Bus[#{num}].mute"))
        end
    end

    def test_it_gets_bus_0to1_mono_value_on
        (0..1).each do |num|
            @@vmr.set_parameter("Bus[#{num}].mono", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(ON, @@vmr.get_parameter("Bus[#{num}].mono"))
        end
    end

    def test_it_gets_bus_0to1_mono_value_off
        (0..1).each do |num|
            @@vmr.set_parameter("Bus[#{num}].mono", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            assert_equal(OFF, @@vmr.get_parameter("Bus[#{num}].mono"))
        end
    end
end

class GetParamsString < Minitest::Test
    def test_it_gets_strips_0to2_label_values
        (0..2).each do |num|
            [
                "testing[0]",
                "testing[1]",
                "testing[2]",
                "reset"
            ].each do |label|
                @@vmr.set_parameter("Strip[#{num}].Label", label)
                assert_equal(SUCCESS, @@vmr.ret)
                assert_equal(label, @@vmr.get_parameter("Strip[#{num}].Label"))
            end
        end
    end
end
