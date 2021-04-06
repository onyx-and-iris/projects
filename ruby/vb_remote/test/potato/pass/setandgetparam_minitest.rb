require_relative '../minitest_helper'

class SetAndGetParamsFloat < Minitest::Test
    def test_it_sets_and_gets_strip0_mono_on
        @@vmr.set_parameter("Strip[0].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[0].mono"))
    end

    def test_it_sets_and_gets_strip1_mono_on
        @@vmr.set_parameter("Strip[1].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[1].mono"))
    end

    def test_it_sets_and_gets_strip2_mc_on
        @@vmr.set_parameter("Strip[2].mc", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[2].mc"))
    end

    def test_it_sets_and_gets_strip0_mono_off
        @@vmr.set_parameter("Strip[0].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[0].mono"))
    end

    def test_it_sets_and_gets_strip1_mono_off
        @@vmr.set_parameter("Strip[1].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[1].mono"))
    end

    def test_it_sets_and_gets_strip2_mc_off
        @@vmr.set_parameter("Strip[2].mc", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[2].mc"))
    end

    def test_it_sets_and_gets_strip0_solo_on
        @@vmr.set_parameter("Strip[0].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[0].solo"))
    end

    def test_it_sets_and_gets_strip1_solo_on
        @@vmr.set_parameter("Strip[1].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[1].solo"))
    end

    def test_it_sets_and_gets_strip2_solo_on
        @@vmr.set_parameter("Strip[2].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[2].solo"))
    end

    def test_it_sets_and_gets_strip0_solo_off
        @@vmr.set_parameter("Strip[0].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[0].solo"))
    end

    def test_it_sets_and_gets_strip1_solo_off
        @@vmr.set_parameter("Strip[1].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[1].solo"))
    end

    def test_it_sets_and_gets_strip2_solo_off
        @@vmr.set_parameter("Strip[2].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[2].solo"))
    end

    def test_it_sets_and_gets_strip0_mute_on
        @@vmr.set_parameter("Strip[0].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[0].mute"))
    end

    def test_it_sets_and_gets_strip1_mute_on
        @@vmr.set_parameter("Strip[1].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[1].mute"))
    end

    def test_it_sets_and_gets_strip2_mute_on
        @@vmr.set_parameter("Strip[2].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[2].mute"))
    end

    def test_it_sets_and_gets_strip0_mute_off
        @@vmr.set_parameter("Strip[0].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[0].mute"))
    end

    def test_it_sets_and_gets_strip1_mute_off
        @@vmr.set_parameter("Strip[1].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[1].mute"))
    end

    def test_it_sets_and_gets_strip2_mute_off
        @@vmr.set_parameter("Strip[2].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[2].mute"))
    end

    def test_it_gets_bus0_mute_value_on
        @@vmr.set_parameter("Bus[0].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[0].mute"))
    end

    def test_it_gets_bus1_mute_value_on
        @@vmr.set_parameter("Bus[1].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[1].mute"))
    end

    def test_it_gets_bus0_mute_value_off
        @@vmr.set_parameter("Bus[0].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[0].mute"))
    end

    def test_it_gets_bus1_mute_value_off
        @@vmr.set_parameter("Bus[1].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[1].mute"))
    end

    def test_it_gets_bus0_mono_value_on
        @@vmr.set_parameter("Bus[0].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[0].mono"))
    end

    def test_it_gets_bus1_mono_value_on
        @@vmr.set_parameter("Bus[1].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[1].mono"))
    end

    def test_it_gets_bus0_mono_value_off
        @@vmr.set_parameter("Bus[0].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[0].mono"))
    end

    def test_it_gets_bus1_mono_value_off
        @@vmr.set_parameter("Bus[1].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[1].mono"))
    end

    def test_it_sets_and_gets_strip0_mute_on_with_alias
        @@vmr.strip[1].mute(ON)
        assert_equal(ON, @@vmr.strip[1].mute)
    end

    def test_it_sets_and_gets_strip1_mute_on_with_alias
        @@vmr.strip[2].mute(ON)
        assert_equal(ON, @@vmr.strip[2].mute)
    end

    def test_it_sets_and_gets_strip2_mute_on_with_alias
        @@vmr.strip[3].mute(ON)
        assert_equal(ON, @@vmr.strip[3].mute)
    end

    def test_it_sets_and_gets_strip0_mute_off_with_alias
        @@vmr.strip[1].mute(OFF)
        assert_equal(OFF, @@vmr.strip[1].mute)
    end

    def test_it_sets_and_gets_strip1_mute_off_with_alias
        @@vmr.strip[2].mute(OFF)
        assert_equal(OFF, @@vmr.strip[2].mute)
    end

    def test_it_sets_and_gets_strip2_mute_off_with_alias
        @@vmr.strip[3].mute(OFF)
        assert_equal(OFF, @@vmr.strip[3].mute)
    end

    def test_it_sets_and_gets_strip0_mono_on_with_alias
        @@vmr.strip[1].mono(ON)
        assert_equal(ON, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_on_with_alias
        @@vmr.strip[2].mono(ON)
        assert_equal(ON, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip0_mono_off_with_alias
        @@vmr.strip[1].mono(OFF)
        assert_equal(OFF, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_off_with_alias
        @@vmr.strip[2].mono(OFF)
        assert_equal(OFF, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip0_solo_on_with_alias
        @@vmr.strip[1].solo(ON)
        assert_equal(ON, @@vmr.strip[1].solo)
    end

    def test_it_sets_and_gets_strip1_solo_on_with_alias
        @@vmr.strip[2].solo(ON)
        assert_equal(ON, @@vmr.strip[2].solo)
    end

    def test_it_sets_and_gets_strip2_solo_on_with_alias
        @@vmr.strip[3].solo(ON)
        assert_equal(ON, @@vmr.strip[3].solo)
    end

    def test_it_sets_and_gets_strip0_solo_off_with_alias
        @@vmr.strip[1].solo(OFF)
        assert_equal(OFF, @@vmr.strip[1].solo)
    end

    def test_it_sets_and_gets_strip1_solo_off_with_alias
        @@vmr.strip[2].solo(OFF)
        assert_equal(OFF, @@vmr.strip[2].solo)
    end

    def test_it_sets_and_gets_strip2_solo_off_with_alias
        @@vmr.strip[3].solo(OFF)
        assert_equal(OFF, @@vmr.strip[3].solo)
    end

    def test_it_sets_and_gets_strip0_A1_on_with_alias
        @@vmr.strip[1].A1(ON)
        assert_equal(ON, @@vmr.strip[1].A1)
    end

    def test_it_sets_and_gets_strip1_A1_on_with_alias
        @@vmr.strip[2].A1(ON)
        assert_equal(ON, @@vmr.strip[2].A1)
    end

    def test_it_sets_and_gets_strip2_A1_on_with_alias
        @@vmr.strip[3].A1(ON)
        assert_equal(ON, @@vmr.strip[3].A1)
    end

    def test_it_sets_and_gets_strip0_A1_off_with_alias
        @@vmr.strip[1].A1(OFF)
        assert_equal(OFF, @@vmr.strip[1].A1)
    end

    def test_it_sets_and_gets_strip1_A1_off_with_alias
        @@vmr.strip[2].A1(OFF)
        assert_equal(OFF, @@vmr.strip[2].A1)
    end

    def test_it_sets_and_gets_strip2_A1_off_with_alias
        @@vmr.strip[3].A1(OFF)
        assert_equal(OFF, @@vmr.strip[3].A1)
    end

    def test_it_sets_and_gets_strip0_B1_on_with_alias
        @@vmr.strip[1].B1(ON)
        assert_equal(ON, @@vmr.strip[1].B1)
    end

    def test_it_sets_and_gets_strip1_B1_on_with_alias
        @@vmr.strip[2].B1(ON)
        assert_equal(ON, @@vmr.strip[2].B1)
    end

    def test_it_sets_and_gets_strip2_B1_on_with_alias
        @@vmr.strip[3].B1(ON)
        assert_equal(ON, @@vmr.strip[3].B1)
    end

    def test_it_sets_and_gets_strip0_B1_off_with_alias
        @@vmr.strip[1].B1(OFF)
        assert_equal(OFF, @@vmr.strip[1].B1)
    end

    def test_it_sets_and_gets_strip1_B1_off_with_alias
        @@vmr.strip[2].B1(OFF)
        assert_equal(OFF, @@vmr.strip[2].B1)
    end

    def test_it_sets_and_gets_strip2_B1_off_with_alias
        @@vmr.strip[3].B1(OFF)
        assert_equal(OFF, @@vmr.strip[3].B1)
    end
end


class SetParamsMulti < Minitest::Test
    def test_it_sets_multiple_params_on_by_hash
        @@param_hash.each do |key, index|
            index.each do |k, v|
                @@param_hash[key][k] = ON
            end
        end

        @@vmr.set_parameter_multi(@@param_hash)
        assert_equal(SUCCESS, @@vmr.ret)
        0.upto(4) do |num|
            [
                "Strip[#{num}].mute",
                "Strip[#{num}].gain",
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "B1", "B2", "mono"]
                b = param
                if a.any? { |s| b.include? s }
                    expected = ON
                else
                    expected = 1.0
                end

                @@vmr.get_parameter(param)
                assert_equal(expected, @@vmr.val)
            end
        end
    end

    def test_it_sets_multiple_params_off_by_hash
        @@param_hash.each do |key, index|
            index.each do |k, v|
                @@param_hash[key][k] = OFF
            end
        end

        @@vmr.set_parameter_multi(@@param_hash)
        assert_equal(SUCCESS, @@vmr.ret)
        0.upto(4) do |num|
            [
                "Strip[#{num}].mute",
                "Strip[#{num}].gain",
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "B1", "B2", "mono"]
                b = param
                if a.any? { |s| b.include? s }
                    expected = OFF
                else
                    expected = 0.0
                end

                @@vmr.get_parameter(param)
                assert_equal(expected, @@vmr.val)
            end
        end
    end
end


class SetAndGetParamsString < Minitest::Test
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
