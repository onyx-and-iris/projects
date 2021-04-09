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

    def test_it_sets_and_gets_strip2_mono_on
        @@vmr.set_parameter("Strip[2].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[2].mono"))
    end

    def test_it_sets_and_gets_strip3_mc_on
        @@vmr.set_parameter("Strip[3].mc", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[3].mc"))
    end

    def test_it_sets_and_gets_strip4_k_on
        @@vmr.set_parameter("Strip[4].k", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[4].k"))
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

    def test_it_sets_and_gets_strip2_mono_off
        @@vmr.set_parameter("Strip[2].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[2].mono"))
    end

    def test_it_sets_and_gets_strip3_mc_off
        @@vmr.set_parameter("Strip[3].mc", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[3].mc"))
    end

    def test_it_sets_and_gets_strip4_k_off
        @@vmr.set_parameter("Strip[4].k", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[4].k"))
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

    def test_it_sets_and_gets_strip3_solo_on
        @@vmr.set_parameter("Strip[3].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[3].solo"))
    end

    def test_it_sets_and_gets_strip4_solo_on
        @@vmr.set_parameter("Strip[4].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[4].solo"))
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

    def test_it_sets_and_gets_strip3_solo_off
        @@vmr.set_parameter("Strip[3].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[3].solo"))
    end

    def test_it_sets_and_gets_strip4_solo_off
        @@vmr.set_parameter("Strip[4].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[4].solo"))
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

    def test_it_sets_and_gets_strip3_mute_on
        @@vmr.set_parameter("Strip[3].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[3].mute"))
    end

    def test_it_sets_and_gets_strip4_mute_on
        @@vmr.set_parameter("Strip[4].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[4].mute"))
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

    def test_it_sets_and_gets_strip3_mute_off
        @@vmr.set_parameter("Strip[3].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[3].mute"))
    end

    def test_it_sets_and_gets_strip4_mute_off
        @@vmr.set_parameter("Strip[4].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[4].mute"))
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

    def test_it_gets_bus2_mute_value_on
        @@vmr.set_parameter("Bus[2].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[2].mute"))
    end

    def test_it_gets_bus3_mute_value_on
        @@vmr.set_parameter("Bus[3].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[3].mute"))
    end

    def test_it_gets_bus4_mute_value_on
        @@vmr.set_parameter("Bus[4].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[4].mute"))
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

    def test_it_gets_bus2_mute_value_off
        @@vmr.set_parameter("Bus[2].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[2].mute"))
    end

    def test_it_gets_bus3_mute_value_off
        @@vmr.set_parameter("Bus[3].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[3].mute"))
    end

    def test_it_gets_bus4_mute_value_off
        @@vmr.set_parameter("Bus[4].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[4].mute"))
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

    def test_it_gets_bus2_mono_value_on
        @@vmr.set_parameter("Bus[2].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[2].mono"))
    end

    def test_it_gets_bus3_mono_value_on
        @@vmr.set_parameter("Bus[3].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[3].mono"))
    end

    def test_it_gets_bus4_mono_value_on
        @@vmr.set_parameter("Bus[4].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[4].mono"))
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

    def test_it_gets_bus2_mono_value_off
        @@vmr.set_parameter("Bus[2].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[2].mono"))
    end

    def test_it_gets_bus3_mono_value_off
        @@vmr.set_parameter("Bus[3].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[3].mono"))
    end

    def test_it_gets_bus4_mono_value_off
        @@vmr.set_parameter("Bus[4].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[4].mono"))
    end
end

class SetAndGetParamsFloatWithAlias < Minitest::Test
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

    def test_it_sets_and_gets_strip3_mute_on_with_alias
        @@vmr.strip[4].mute(ON)
        assert_equal(ON, @@vmr.strip[4].mute)
    end

    def test_it_sets_and_gets_strip4_mute_on_with_alias
        @@vmr.strip[5].mute(ON)
        assert_equal(ON, @@vmr.strip[5].mute)
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

    def test_it_sets_and_gets_strip3_mute_off_with_alias
        @@vmr.strip[4].mute(OFF)
        assert_equal(OFF, @@vmr.strip[4].mute)
    end

    def test_it_sets_and_gets_strip4_mute_off_with_alias
        @@vmr.strip[5].mute(OFF)
        assert_equal(OFF, @@vmr.strip[5].mute)
    end

    def test_it_sets_and_gets_strip0_mono_on_with_alias
        @@vmr.strip[1].mono(ON)
        assert_equal(ON, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_on_with_alias
        @@vmr.strip[2].mono(ON)
        assert_equal(ON, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip2_mono_on_with_alias
        @@vmr.strip[3].mono(ON)
        assert_equal(ON, @@vmr.strip[3].mono)
    end

    def test_it_sets_and_gets_strip3_mc_on_with_alias
        @@vmr.strip[4].mc(ON)
        assert_equal(ON, @@vmr.strip[4].mc)
    end

    def test_it_sets_and_gets_strip4_k_on_with_alias
        @@vmr.strip[5].k(ON)
        assert_equal(ON, @@vmr.strip[5].k)
    end

    def test_it_sets_and_gets_strip0_mono_off_with_alias
        @@vmr.strip[1].mono(OFF)
        assert_equal(OFF, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_off_with_alias
        @@vmr.strip[2].mono(OFF)
        assert_equal(OFF, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip2_mono_off_with_alias
        @@vmr.strip[3].mono(OFF)
        assert_equal(OFF, @@vmr.strip[3].mono)
    end

    def test_it_sets_and_gets_strip3_mc_off_with_alias
        @@vmr.strip[4].mc(OFF)
        assert_equal(OFF, @@vmr.strip[4].mc)
    end

    def test_it_sets_and_gets_strip4_k_off_with_alias
        @@vmr.strip[5].k(OFF)
        assert_equal(OFF, @@vmr.strip[5].k)
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

    def test_it_sets_and_gets_strip3_solo_on_with_alias
        @@vmr.strip[4].solo(ON)
        assert_equal(ON, @@vmr.strip[4].solo)
    end

    def test_it_sets_and_gets_strip4_solo_on_with_alias
        @@vmr.strip[5].solo(ON)
        assert_equal(ON, @@vmr.strip[5].solo)
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

    def test_it_sets_and_gets_strip3_solo_off_with_alias
        @@vmr.strip[4].solo(OFF)
        assert_equal(OFF, @@vmr.strip[4].solo)
    end

    def test_it_sets_and_gets_strip4_solo_off_with_alias
        @@vmr.strip[5].solo(OFF)
        assert_equal(OFF, @@vmr.strip[5].solo)
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

    def test_it_sets_and_gets_strip3_A1_on_with_alias
        @@vmr.strip[4].A1(ON)
        assert_equal(ON, @@vmr.strip[4].A1)
    end

    def test_it_sets_and_gets_strip4_A1_on_with_alias
        @@vmr.strip[5].A1(ON)
        assert_equal(ON, @@vmr.strip[5].A1)
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

    def test_it_sets_and_gets_strip3_A1_off_with_alias
        @@vmr.strip[4].A1(OFF)
        assert_equal(OFF, @@vmr.strip[4].A1)
    end

    def test_it_sets_and_gets_strip4_A1_off_with_alias
        @@vmr.strip[5].A1(OFF)
        assert_equal(OFF, @@vmr.strip[5].A1)
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

    def test_it_sets_and_gets_strip3_B1_on_with_alias
        @@vmr.strip[4].B1(ON)
        assert_equal(ON, @@vmr.strip[4].B1)
    end

    def test_it_sets_and_gets_strip4_B1_on_with_alias
        @@vmr.strip[5].B1(ON)
        assert_equal(ON, @@vmr.strip[5].B1)
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

    def test_it_sets_and_gets_strip3_B1_off_with_alias
        @@vmr.strip[4].B1(OFF)
        assert_equal(OFF, @@vmr.strip[4].B1)
    end

    def test_it_sets_and_gets_strip4_B1_off_with_alias
        @@vmr.strip[5].B1(OFF)
        assert_equal(OFF, @@vmr.strip[5].B1)
    end
end
