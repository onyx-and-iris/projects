require 'minitest/autorun'
require 'routines'

class MiniTest::Test
    OFF = 0
    ON = 1
    SUCCESS = 0
    ERROR = 1

    @@vmr = Remote.new("banana", "login")

    @@param_hash = {
        :strip_1 => {"mute" => ON, "gain" => ON, "A2" => ON},
        :strip_2 => {"mute" => ON, "gain" => ON, "A2" => ON},
        :strip_3 => {"mute" => ON, "gain" => ON, "A2" => ON},
        :strip_4 => {"mute" => ON, "gain" => ON, "A2" => ON},
        :strip_5 => {"mute" => ON, "gain" => ON, "A2" => ON},
        :bus_1 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_2 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_3 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_4 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_5 => {"mute" => ON, "gain" => ON, "mono" => ON}
    }

    def setup
    end

    def teardown
    end

    def after_tests
        @@vmr.do_logout
    end 
end
