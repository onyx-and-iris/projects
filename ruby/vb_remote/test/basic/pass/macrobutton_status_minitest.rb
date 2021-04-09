require_relative '../minitest_helper'

class MacroButtonStatus < Minitest::Test
    def test_it_sets_macrobutton0_state_on
        @@vmr.macro_setstatus(0, ON, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(0, 1))
    end

    def test_it_sets_macrobutton1_state_on
        @@vmr.macro_setstatus(1, ON, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(1, 1))
    end

    def test_it_sets_macrobutton2_state_on
        @@vmr.macro_setstatus(2, ON, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(2, 1))
    end

    def test_it_sets_macrobutton0_state_off
        @@vmr.macro_setstatus(0, OFF, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(0, 1))
    end

    def test_it_sets_macrobutton1_state_off
        @@vmr.macro_setstatus(1, OFF, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(1, 1))
    end

    def test_it_sets_macrobutton2_state_off
        @@vmr.macro_setstatus(2, OFF, 1)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(2, 1))
    end

    def test_it_sets_macrobuttons0_stateonly_on
        @@vmr.macro_setstatus(0, ON, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(0, 2))
    end

    def test_it_sets_macrobuttons1_stateonly_on
        @@vmr.macro_setstatus(1, ON, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(1, 2))
    end

    def test_it_sets_macrobuttons2_stateonly_on
        @@vmr.macro_setstatus(2, ON, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(2, 2))
    end

    def test_it_sets_macrobuttons0_stateonly_off 
        @@vmr.macro_setstatus(0, OFF, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(0, 2))
    end

    def test_it_sets_macrobuttons1_stateonly_off 
        @@vmr.macro_setstatus(1, OFF, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(1, 2))
    end

    def test_it_sets_macrobuttons2_stateonly_off 
        @@vmr.macro_setstatus(2, OFF, 2)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(2, 2))
    end

    def test_it_sets_macrobuttons0_trigger_on
        @@vmr.macro_setstatus(0, ON, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(0, 3))
    end

    def test_it_sets_macrobuttons1_trigger_on
        @@vmr.macro_setstatus(1, ON, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(1, 3))
    end

    def test_it_sets_macrobuttons2_trigger_on
        @@vmr.macro_setstatus(2, ON, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.macro_getstatus(2, 3))
    end

    def test_it_sets_macrobuttons0_trigger_off
        @@vmr.macro_setstatus(0, OFF, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(0, 3))
    end

    def test_it_sets_macrobuttons1_trigger_off
        @@vmr.macro_setstatus(1, OFF, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(1, 3))
    end

    def test_it_sets_macrobuttons2_trigger_off
        @@vmr.macro_setstatus(2, OFF, 3)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.macro_getstatus(2, 3))
    end
end
