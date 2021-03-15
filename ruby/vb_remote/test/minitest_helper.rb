require 'routines'

class MiniTest::Test
    OFF = 0
    ON = 1
    SUCCESS = 0
    ERROR = 1

    @@vmr = Remote.new(true)

    def setup
    end

    def teardown
    end

    def after_tests
        @@vmr.do_logout
    end 
end
