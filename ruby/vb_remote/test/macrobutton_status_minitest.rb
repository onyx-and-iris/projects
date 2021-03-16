require 'minitest/autorun'
require_relative 'minitest_helper'

class MacroButtonStatusSuccess < Minitest::Test
    def test_it_sets_macrobuttons_0to2_state_on
        (0..2).each do |num|
            @@vmr.macro_setstatus(num, ON, 1)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_macrobuttons_0to2_state_off
        (0..2).each do |num|
            @@vmr.macro_setstatus(num, OFF, 1)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_macrobuttons_0to2_stateonly_on
        (0..2).each do |num|
            @@vmr.macro_setstatus(num, ON, 2)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_macrobuttons_0to2_stateonly_off
        (0..2).each do |num|  
            @@vmr.macro_setstatus(num, OFF, 2)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_macrobuttons_0to2_trigger_on
        (0..2).each do |num| 
            @@vmr.macro_setstatus(num, ON, 3)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_macrobuttons_0to2_trigger_off
        (0..2).each do |num| 
            @@vmr.macro_setstatus(num, OFF, 3)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end
end

class MacroButtonStatusBoundsError < Minitest::Test
    def test_it_raises_a_testing_error_for_macrobutton_99
        assert_raises(TestingError) do
            @@vmr.macro_setstatus(99, ON, 2)
        end
    end
end
