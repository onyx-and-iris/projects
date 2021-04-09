require_relative '../minitest_helper'

class SetAndGetParamsFloatWithAlias < Minitest::Test
    def test_it_sets_and_gets_strip0_mute_on_with_alias
        @@vmr.strip[1].mute = ON
        assert_equal(ON, @@vmr.strip[1].mute)
    end

    def test_it_sets_and_gets_strip1_mute_on_with_alias
        @@vmr.strip[2].mute = ON
        assert_equal(ON, @@vmr.strip[2].mute)
    end

    def test_it_sets_and_gets_strip2_mute_on_with_alias
        @@vmr.strip[3].mute = ON
        assert_equal(ON, @@vmr.strip[3].mute)
    end

    def test_it_sets_and_gets_strip0_mute_off_with_alias
        @@vmr.strip[1].mute = OFF
        assert_equal(OFF, @@vmr.strip[1].mute)
    end

    def test_it_sets_and_gets_strip1_mute_off_with_alias
        @@vmr.strip[2].mute = OFF
        assert_equal(OFF, @@vmr.strip[2].mute)
    end

    def test_it_sets_and_gets_strip2_mute_off_with_alias
        @@vmr.strip[3].mute = OFF
        assert_equal(OFF, @@vmr.strip[3].mute)
    end

    def test_it_sets_and_gets_strip0_mono_on_with_alias
        @@vmr.strip[1].mono = ON
        assert_equal(ON, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_on_with_alias
        @@vmr.strip[2].mono = ON
        assert_equal(ON, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip0_mono_off_with_alias
        @@vmr.strip[1].mono = OFF
        assert_equal(OFF, @@vmr.strip[1].mono)
    end

    def test_it_sets_and_gets_strip1_mono_off_with_alias
        @@vmr.strip[2].mono = OFF
        assert_equal(OFF, @@vmr.strip[2].mono)
    end

    def test_it_sets_and_gets_strip0_solo_on_with_alias
        @@vmr.strip[1].solo = ON
        assert_equal(ON, @@vmr.strip[1].solo)
    end

    def test_it_sets_and_gets_strip1_solo_on_with_alias
        @@vmr.strip[2].solo = ON
        assert_equal(ON, @@vmr.strip[2].solo)
    end

    def test_it_sets_and_gets_strip2_solo_on_with_alias
        @@vmr.strip[3].solo = ON
        assert_equal(ON, @@vmr.strip[3].solo)
    end

    def test_it_sets_and_gets_strip0_solo_off_with_alias
        @@vmr.strip[1].solo = OFF
        assert_equal(OFF, @@vmr.strip[1].solo)
    end

    def test_it_sets_and_gets_strip1_solo_off_with_alias
        @@vmr.strip[2].solo = OFF
        assert_equal(OFF, @@vmr.strip[2].solo)
    end

    def test_it_sets_and_gets_strip2_solo_off_with_alias
        @@vmr.strip[3].solo = OFF
        assert_equal(OFF, @@vmr.strip[3].solo)
    end

    def test_it_sets_and_gets_strip0_A1_on_with_alias
        @@vmr.strip[1].A1 = ON
        assert_equal(ON, @@vmr.strip[1].A1)
    end

    def test_it_sets_and_gets_strip1_A1_on_with_alias
        @@vmr.strip[2].A1 = ON
        assert_equal(ON, @@vmr.strip[2].A1)
    end

    def test_it_sets_and_gets_strip2_A1_on_with_alias
        @@vmr.strip[3].A1 = ON
        assert_equal(ON, @@vmr.strip[3].A1)
    end

    def test_it_sets_and_gets_strip0_A1_off_with_alias
        @@vmr.strip[1].A1 = OFF
        assert_equal(OFF, @@vmr.strip[1].A1)
    end

    def test_it_sets_and_gets_strip1_A1_off_with_alias
        @@vmr.strip[2].A1 = OFF
        assert_equal(OFF, @@vmr.strip[2].A1)
    end

    def test_it_sets_and_gets_strip2_A1_off_with_alias
        @@vmr.strip[3].A1 = OFF
        assert_equal(OFF, @@vmr.strip[3].A1)
    end

    def test_it_sets_and_gets_strip0_B1_on_with_alias
        @@vmr.strip[1].B1 = ON
        assert_equal(ON, @@vmr.strip[1].B1)
    end

    def test_it_sets_and_gets_strip1_B1_on_with_alias
        @@vmr.strip[2].B1 = ON
        assert_equal(ON, @@vmr.strip[2].B1)
    end

    def test_it_sets_and_gets_strip2_B1_on_with_alias
        @@vmr.strip[3].B1 = ON
        assert_equal(ON, @@vmr.strip[3].B1)
    end

    def test_it_sets_and_gets_strip0_B1_off_with_alias
        @@vmr.strip[1].B1 = OFF
        assert_equal(OFF, @@vmr.strip[1].B1)
    end

    def test_it_sets_and_gets_strip1_B1_off_with_alias
        @@vmr.strip[2].B1 = OFF
        assert_equal(OFF, @@vmr.strip[2].B1)
    end

    def test_it_sets_and_gets_strip2_B1_off_with_alias
        @@vmr.strip[3].B1 = OFF
        assert_equal(OFF, @@vmr.strip[3].B1)
    end
end
