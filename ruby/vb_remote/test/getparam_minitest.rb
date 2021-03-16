require 'minitest/autorun'
require_relative 'minitest_helper'

class GetParamsFloat < Minitest::Test
    def test_it_gets_strip_0to1_mono_value_on
        (0..1).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].mono")
            assert_equal(ON, @@vmr.val)
        end
    end

    def test_it_gets_strip_0to1_mono_value_off
        (0..1).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].mono")
            assert_equal(OFF, @@vmr.val)
        end
    end

    def test_it_gets_strip_0to2_solo_value_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].solo")
            assert_equal(ON, @@vmr.val)
        end
    end

    def test_it_gets_strip_0to2_solo_value_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].solo")
            assert_equal(OFF, @@vmr.val)
        end
    end

    def test_it_gets_strip_0to2_mute_value_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", ON)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].mute")
            assert_equal(ON, @@vmr.val)
        end
    end

    def test_it_gets_strip_0to2_mute_value_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter("Strip[#{num}].mute")
            assert_equal(OFF, @@vmr.val)
        end
    end
end

class GetParamsString < Minitest::Test
    def test_it_gets_strip_0to2_label_value0
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].Label", "testing[0]")
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter_string("Strip[#{num}].Label")
            assert_equal("testing[0]", @@vmr.val)
        end
    end

    def test_it_gets_strip_0to2_label_value1
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].Label", "testing[1]")
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter_string("Strip[#{num}].Label")
            assert_equal("testing[1]", @@vmr.val)        
        end
    end

    def test_it_gets_strip_0to2_label_value2
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].Label", "testing[2]")
            assert_equal(SUCCESS, @@vmr.ret)
            @@vmr.get_parameter_string("Strip[#{num}].Label")
            assert_equal("testing[2]", @@vmr.val)
        end
    end
end