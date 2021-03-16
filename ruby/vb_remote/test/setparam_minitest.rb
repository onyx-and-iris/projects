require_relative 'minitest_helper'

class SetParamsFloat < Minitest::Test
    def test_it_sets_strip_0to1_mono_on
        (0..1).each do |num|
            @@vmr.set_parameter("Strip[#{num}].mono", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_strip_0to1_mono_off
        (0..1).each do |num|
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

class SetParamsMulti < Minitest::Test
    def test_it_sets_multiple_params_on_by_hash
        @@vmr.set_parameter_multi(@@param_hash)
        assert_equal(SUCCESS, @@vmr.ret)
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].mute")
            assert_equal(ON, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].gain")
            assert_equal(ON, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].A2")
            assert_equal(ON, @@vmr.val)
        end

        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].mute")
            assert_equal(ON, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].gain")
            assert_equal(ON, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].mono")
            assert_equal(ON, @@vmr.val)
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
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].mute")
            assert_equal(OFF, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].gain")
            assert_equal(OFF, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Strip[#{num}].A2")
            assert_equal(OFF, @@vmr.val)
        end

        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].mute")
            assert_equal(OFF, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].gain")
            assert_equal(OFF, @@vmr.val)
        end
        (0..4).each do |num|
            @@vmr.get_parameter("Bus[#{num}].mono")
            assert_equal(OFF, @@vmr.val)
        end
    end
end