require 'minitest/autorun'
require_relative 'minitest_helper'

class TestRemote < Minitest::Test
    def test_it_sets_strip_0to2_mono_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to2_mono_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to2_solo_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to2_solo_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].solo", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to2_mute_on
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to2_mute_off
        (0..2).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mute", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end
end
