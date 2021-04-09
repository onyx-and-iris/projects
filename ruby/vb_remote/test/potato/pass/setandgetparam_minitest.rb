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

    def test_it_sets_and_gets_strip3_mono_on
        @@vmr.set_parameter("Strip[3].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[3].mono"))
    end

    def test_it_sets_and_gets_strip4_mono_on
        @@vmr.set_parameter("Strip[4].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[4].mono"))
    end

    def test_it_sets_and_gets_strip5_mc_on
        @@vmr.set_parameter("Strip[5].mc", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[5].mc"))
    end

    def test_it_sets_and_gets_strip6_k_on
        @@vmr.set_parameter("Strip[6].k", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[6].k"))
    end

    def test_it_sets_and_gets_strip7_mc_on
        @@vmr.set_parameter("Strip[7].mc", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[7].mc"))
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

    def test_it_sets_and_gets_strip3_mono_off
        @@vmr.set_parameter("Strip[3].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[3].mono"))
    end

    def test_it_sets_and_gets_strip4_mono_off
        @@vmr.set_parameter("Strip[4].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[4].mono"))
    end

    def test_it_sets_and_gets_strip5_mc_off
        @@vmr.set_parameter("Strip[5].mc", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[5].mc"))
    end

    def test_it_sets_and_gets_strip6_k_off
        @@vmr.set_parameter("Strip[6].k", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[6].k"))
    end

    def test_it_sets_and_gets_strip7_mc_off
        @@vmr.set_parameter("Strip[7].mc", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[7].mc"))
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

    def test_it_sets_and_gets_strip5_solo_on
        @@vmr.set_parameter("Strip[5].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[5].solo"))
    end

    def test_it_sets_and_gets_strip6_solo_on
        @@vmr.set_parameter("Strip[6].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[6].solo"))
    end

    def test_it_sets_and_gets_strip7_solo_on
        @@vmr.set_parameter("Strip[7].solo", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[7].solo"))
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

    def test_it_sets_and_gets_strip5_solo_off
        @@vmr.set_parameter("Strip[5].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[5].solo"))
    end

    def test_it_sets_and_gets_strip6_solo_off
        @@vmr.set_parameter("Strip[6].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[6].solo"))
    end

    def test_it_sets_and_gets_strip7_solo_off
        @@vmr.set_parameter("Strip[7].solo", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[7].solo"))
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

    def test_it_sets_and_gets_strip5_mute_on
        @@vmr.set_parameter("Strip[5].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[5].mute"))
    end

    def test_it_sets_and_gets_strip6_mute_on
        @@vmr.set_parameter("Strip[6].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[6].mute"))
    end

    def test_it_sets_and_gets_strip7_mute_on
        @@vmr.set_parameter("Strip[7].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Strip[7].mute"))
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

    def test_it_sets_and_gets_strip5_mute_off
        @@vmr.set_parameter("Strip[5].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[5].mute"))
    end

    def test_it_sets_and_gets_strip6_mute_off
        @@vmr.set_parameter("Strip[6].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[6].mute"))
    end

    def test_it_sets_and_gets_strip7_mute_off
        @@vmr.set_parameter("Strip[7].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Strip[7].mute"))
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

    def test_it_gets_bus5_mute_value_on
        @@vmr.set_parameter("Bus[5].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[5].mute"))
    end

    def test_it_gets_bus6_mute_value_on
        @@vmr.set_parameter("Bus[6].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[6].mute"))
    end

    def test_it_gets_bus7_mute_value_on
        @@vmr.set_parameter("Bus[7].mute", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[7].mute"))
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

    def test_it_gets_bus5_mute_value_off
        @@vmr.set_parameter("Bus[5].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[5].mute"))
    end

    def test_it_gets_bus6_mute_value_off
        @@vmr.set_parameter("Bus[6].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[6].mute"))
    end

    def test_it_gets_bus7_mute_value_off
        @@vmr.set_parameter("Bus[7].mute", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[7].mute"))
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

    def test_it_gets_bus5_mono_value_on
        @@vmr.set_parameter("Bus[5].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[5].mono"))
    end

    def test_it_gets_bus6_mono_value_on
        @@vmr.set_parameter("Bus[6].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[6].mono"))
    end

    def test_it_gets_bus7_mono_value_on
        @@vmr.set_parameter("Bus[7].mono", ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.get_parameter("Bus[7].mono"))
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

    def test_it_gets_bus5_mono_value_off
        @@vmr.set_parameter("Bus[5].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[5].mono"))
    end

    def test_it_gets_bus6_mono_value_off
        @@vmr.set_parameter("Bus[6].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[6].mono"))
    end

    def test_it_gets_bus7_mono_value_off
        @@vmr.set_parameter("Bus[7].mono", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.get_parameter("Bus[7].mono"))
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

    def test_it_sets_and_gets_strip5_mute_on_with_alias
        @@vmr.strip[6].mute(ON)
        assert_equal(ON, @@vmr.strip[6].mute)
    end

    def test_it_sets_and_gets_strip6_mute_on_with_alias
        @@vmr.strip[7].mute(ON)
        assert_equal(ON, @@vmr.strip[7].mute)
    end

    def test_it_sets_and_gets_strip7_mute_on_with_alias
        @@vmr.strip[8].mute(ON)
        assert_equal(ON, @@vmr.strip[8].mute)
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

    def test_it_sets_and_gets_strip5_mute_off_with_alias
        @@vmr.strip[6].mute(OFF)
        assert_equal(OFF, @@vmr.strip[6].mute)
    end

    def test_it_sets_and_gets_strip6_mute_off_with_alias
        @@vmr.strip[7].mute(OFF)
        assert_equal(OFF, @@vmr.strip[7].mute)
    end

    def test_it_sets_and_gets_strip7_mute_off_with_alias
        @@vmr.strip[8].mute(OFF)
        assert_equal(OFF, @@vmr.strip[8].mute)
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

    def test_it_sets_and_gets_strip3_mono_on_with_alias
        @@vmr.strip[4].mono(ON)
        assert_equal(ON, @@vmr.strip[4].mono)
    end

    def test_it_sets_and_gets_strip4_mono_on_with_alias
        @@vmr.strip[5].mono(ON)
        assert_equal(ON, @@vmr.strip[5].mono)
    end

    def test_it_sets_and_gets_strip5_mc_on_with_alias
        @@vmr.strip[6].mc(ON)
        assert_equal(ON, @@vmr.strip[6].mc)
    end

    def test_it_sets_and_gets_strip6_k_on_with_alias
        @@vmr.strip[7].k(ON)
        assert_equal(ON, @@vmr.strip[7].k)
    end

    def test_it_sets_and_gets_strip7_mc_on_with_alias
        @@vmr.strip[8].mc(ON)
        assert_equal(ON, @@vmr.strip[8].mc)
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

    def test_it_sets_and_gets_strip4_mc_off_with_alias
        @@vmr.strip[5].mc(OFF)
        assert_equal(OFF, @@vmr.strip[5].mc)
    end

    def test_it_sets_and_gets_strip5_mc_off_with_alias
        @@vmr.strip[6].mc(OFF)
        assert_equal(OFF, @@vmr.strip[6].mc)
    end

    def test_it_sets_and_gets_strip6_k_off_with_alias
        @@vmr.strip[7].k(OFF)
        assert_equal(OFF, @@vmr.strip[7].k)
    end

    def test_it_sets_and_gets_strip7_mc_off_with_alias
        @@vmr.strip[8].mc(OFF)
        assert_equal(OFF, @@vmr.strip[8].mc)
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

    def test_it_sets_and_gets_strip5_solo_on_with_alias
        @@vmr.strip[6].solo(ON)
        assert_equal(ON, @@vmr.strip[6].solo)
    end

    def test_it_sets_and_gets_strip6_solo_on_with_alias
        @@vmr.strip[7].solo(ON)
        assert_equal(ON, @@vmr.strip[7].solo)
    end

    def test_it_sets_and_gets_strip7_solo_on_with_alias
        @@vmr.strip[8].solo(ON)
        assert_equal(ON, @@vmr.strip[8].solo)
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

    def test_it_sets_and_gets_strip5_solo_off_with_alias
        @@vmr.strip[6].solo(OFF)
        assert_equal(OFF, @@vmr.strip[6].solo)
    end

    def test_it_sets_and_gets_strip6_solo_off_with_alias
        @@vmr.strip[7].solo(OFF)
        assert_equal(OFF, @@vmr.strip[7].solo)
    end

    def test_it_sets_and_gets_strip7_solo_off_with_alias
        @@vmr.strip[8].solo(OFF)
        assert_equal(OFF, @@vmr.strip[8].solo)
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

    def test_it_sets_and_gets_strip5_A1_on_with_alias
        @@vmr.strip[6].A1(ON)
        assert_equal(ON, @@vmr.strip[6].A1)
    end

    def test_it_sets_and_gets_strip6_A1_on_with_alias
        @@vmr.strip[7].A1(ON)
        assert_equal(ON, @@vmr.strip[7].A1)
    end

    def test_it_sets_and_gets_strip7_A1_on_with_alias
        @@vmr.strip[8].A1(ON)
        assert_equal(ON, @@vmr.strip[8].A1)
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

    def test_it_sets_and_gets_strip5_A1_off_with_alias
        @@vmr.strip[6].A1(OFF)
        assert_equal(OFF, @@vmr.strip[6].A1)
    end

    def test_it_sets_and_gets_strip6_A1_off_with_alias
        @@vmr.strip[7].A1(OFF)
        assert_equal(OFF, @@vmr.strip[7].A1)
    end

    def test_it_sets_and_gets_strip7_A1_off_with_alias
        @@vmr.strip[8].A1(OFF)
        assert_equal(OFF, @@vmr.strip[8].A1)
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

    def test_it_sets_and_gets_strip5_B1_on_with_alias
        @@vmr.strip[6].B1(ON)
        assert_equal(ON, @@vmr.strip[6].B1)
    end

    def test_it_sets_and_gets_strip6_B1_on_with_alias
        @@vmr.strip[7].B1(ON)
        assert_equal(ON, @@vmr.strip[7].B1)
    end

    def test_it_sets_and_gets_strip7_B1_on_with_alias
        @@vmr.strip[8].B1(ON)
        assert_equal(ON, @@vmr.strip[8].B1)
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

    def test_it_sets_and_gets_strip5_B1_off_with_alias
        @@vmr.strip[6].B1(OFF)
        assert_equal(OFF, @@vmr.strip[6].B1)
    end

    def test_it_sets_and_gets_strip6_B1_off_with_alias
        @@vmr.strip[7].B1(OFF)
        assert_equal(OFF, @@vmr.strip[7].B1)
    end

    def test_it_sets_and_gets_strip7_B1_off_with_alias
        @@vmr.strip[8].B1(OFF)
        assert_equal(OFF, @@vmr.strip[8].B1)
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
        0.upto(7) do |num|
            [
                "Strip[#{num}].mute",
                "Strip[#{num}].gain",
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].A4",
                "Strip[#{num}].A5",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Strip[#{num}].B3",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "mono"]
                b = param
                if a.any? { |s| b.include? s }
                    expected = ON
                else
                    expected = 1.0
                end

                assert_equal(expected, @@vmr.get_parameter(param))
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
        0.upto(7) do |num|
            [
                "Strip[#{num}].mute",
                "Strip[#{num}].gain",
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].A4",
                "Strip[#{num}].A5",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Strip[#{num}].B3",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "A4", "A5", "B1", "B2", "B3", "mono"]
                b = param
                if a.any? { |s| b.include? s }
                    expected = OFF
                else
                    expected = 0.0
                end

                assert_equal(expected, @@vmr.get_parameter(param))
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
