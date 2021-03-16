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
                "Strip[#{num}].A2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A2", "mono"]
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
                "Strip[#{num}].A2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A2", "mono"]
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
