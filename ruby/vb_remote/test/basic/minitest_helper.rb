require 'minitest/autorun'
require 'routines'

class MiniTest::Test
    OFF = 0
    ON = 1
    SUCCESS = 0
    ERROR = 1

    @@vmr = Remote.new("basic", "login")

    @@param_hash = {
        :strip_1 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_2 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_3 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :bus_1 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_2 => {"mute" => ON, "gain" => ON, "mono" => ON},
    }

    def setup
    end

    def teardown
    end

    def after_tests
        @@vmr.do_logout
    end 
end
