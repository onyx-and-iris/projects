require 'minitest/autorun'
require_relative 'minitest_helper'

class SetVban < Minitest::Test
    def test_it_sets_vban_instream_0to2_on
        (0..2).each do |num|
            @@vmr.set_parameter("vban.instream[#{num}].on", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_vban_instream_0to2_off
        (0..2).each do |num|
            @@vmr.set_parameter("vban.instream[#{num}].on", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_vban_outstream_0to2_on
        (0..2).each do |num|
            @@vmr.set_parameter("vban.outstream[#{num}].on", ON)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end

    def test_it_sets_vban_outstream_0to2_off
        (0..2).each do |num|
            @@vmr.set_parameter("vban.outstream[#{num}].on", OFF)
            assert_equal(SUCCESS, @@vmr.ret)
        end
    end
end