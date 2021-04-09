require_relative '../minitest_helper'

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