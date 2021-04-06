require_relative '../minitest_helper'

class MacroButtonStatusSuccess < Minitest::Test
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

    def test_it_sets_macrobutton0_state_on_with_alias
        @@vmr.button_state(id: 0, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_state(id: 0))
    end

    def test_it_sets_macrobutton1_state_on_with_alias
        @@vmr.button_state(id: 1, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_state(id: 1))
    end

    def test_it_sets_macrobutton2_state_on_with_alias
        @@vmr.button_state(id: 2, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_state(id: 2))
    end

    def test_it_sets_macrobutton0_state_off_with_alias
        @@vmr.button_state(id: 0, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_state(id: 0))
    end

    def test_it_sets_macrobutton1_state_off_with_alias
        @@vmr.button_state(id: 1, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_state(id: 1))
    end

    def test_it_sets_macrobutton2_state_off_with_alias
        @@vmr.button_state(id: 2, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_state(id: 2))
    end

    def test_it_sets_macrobutton0_stateonly_on_with_alias
        @@vmr.button_stateonly(id: 0, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_stateonly(id: 0))
    end

    def test_it_sets_macrobutton1_stateonly_on_with_alias
        @@vmr.button_stateonly(id: 1, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_stateonly(id: 1))
    end

    def test_it_sets_macrobutton2_stateonly_on_with_alias
        @@vmr.button_stateonly(id: 2, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_stateonly(id: 2))
    end

    def test_it_sets_macrobutton0_stateonly_off_with_alias
        @@vmr.button_stateonly(id: 0, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_stateonly(id: 0))
    end

    def test_it_sets_macrobutton1_stateonly_off_with_alias
        @@vmr.button_stateonly(id: 1, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_stateonly(id: 1))
    end

    def test_it_sets_macrobutton2_stateonly_off_with_alias
        @@vmr.button_stateonly(id: 2, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_stateonly(id: 2))
    end

    def test_it_sets_macrobutton0_trigger_on_with_alias
        @@vmr.button_trigger(id: 0, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_trigger(id: 0))
    end

    def test_it_sets_macrobutton1_trigger_on_with_alias
        @@vmr.button_trigger(id: 1, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_trigger(id: 1))
    end

    def test_it_sets_macrobutton2_trigger_on_with_alias
        @@vmr.button_trigger(id: 2, set: ON)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(ON, @@vmr.button_trigger(id: 2))
    end

    def test_it_sets_macrobutton0_trigger_off_with_alias
        @@vmr.button_trigger(id: 0, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_trigger(id: 0))
    end

    def test_it_sets_macrobutton1_trigger_off_with_alias
        @@vmr.button_trigger(id: 1, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_trigger(id: 1))
    end

    def test_it_sets_macrobutton2_trigger_off_with_alias
        @@vmr.button_trigger(id: 2, set: OFF)
        assert_equal(SUCCESS, @@vmr.ret)
        assert_equal(OFF, @@vmr.button_trigger(id: 2))
    end
end
