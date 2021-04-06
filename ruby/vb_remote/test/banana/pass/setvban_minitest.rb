require_relative '../minitest_helper'

class SetVban < Minitest::Test
    def test_it_sets_vban_instream0_on
        @@vmr.set_parameter("vban.instream[0].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream1_on
        @@vmr.set_parameter("vban.instream[1].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream2_on
        @@vmr.set_parameter("vban.instream[2].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream3_on
        @@vmr.set_parameter("vban.instream[3].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream0_off
        @@vmr.set_parameter("vban.instream[0].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream1_off
        @@vmr.set_parameter("vban.instream[1].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream2_off
        @@vmr.set_parameter("vban.instream[2].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_instream3_off
        @@vmr.set_parameter("vban.instream[3].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream0_on
        @@vmr.set_parameter("vban.outstream[0].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream1_on
        @@vmr.set_parameter("vban.outstream[1].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream2_on
        @@vmr.set_parameter("vban.outstream[2].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream3_on
        @@vmr.set_parameter("vban.outstream[3].on", ON)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream0_off
        @@vmr.set_parameter("vban.outstream[0].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream1_off
        @@vmr.set_parameter("vban.outstream[1].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream2_off
        @@vmr.set_parameter("vban.outstream[2].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end

    def test_it_sets_vban_outstream3_off
        @@vmr.set_parameter("vban.outstream[3].on", OFF)
        assert_equal(SUCCESS, @@vmr.ret)
    end
end
