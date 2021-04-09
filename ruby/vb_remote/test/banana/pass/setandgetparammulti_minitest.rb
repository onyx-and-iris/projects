require_relative '../minitest_helper'

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
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "B1", "B2", "mono"]
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
        0.upto(4) do |num|
            [
                "Strip[#{num}].mute",
                "Strip[#{num}].gain",
                "Strip[#{num}].A1",
                "Strip[#{num}].A2",
                "Strip[#{num}].A3",
                "Strip[#{num}].B1",
                "Strip[#{num}].B2",
                "Bus[#{num}].mute",
                "Bus[#{num}].gain",
                "Bus[#{num}].mono"
            ].each do |param|
                a = ["mute", "A1", "A2", "A3", "B1", "B2", "mono"]
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
