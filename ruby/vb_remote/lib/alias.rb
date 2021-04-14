module Alias
    attr_reader :recorder, :button, :vban, :vban_in, :vban_out

    def recorder=(value)
        @recorder = value
    end

    def button=(value)
        @button = value
    end

    def vban=(value)
        set_parameter("vban.Enable", value)
    end

    def vban_in=(value)
        @vban_in = value
    end

    def vban_out=(value)
        @vban_out = value
    end

    def create_alias
        self.recorder = Recorder.new(self)
        self.button = []
        (0..69).each_with_index do |num, index|
            @button[num] = Macrobutton.new(self, index)
        end

        self.vban_in = []
        (0..@layout[:in_vban]).each_with_index do |num, index|
            @vban_in[num] = VBAN.new(self, index, "in")
        end
        self.vban_out = []
        (0..@layout[:out_vban]).each_with_index do |num, index|
            @vban_out[num] = VBAN.new(self, index, "out")
        end
    end

    class Alias
        attr_accessor :run

        def run=(value)
            @run = value
        end

        def initialize(run)
            self.run = run
        end
    end

    class Macrobutton < Alias
        attr_accessor :id

        def id=(value)
            @id = value
        end

        def initialize(run, index)
            super(run)
            self.id = index
        end

        def set(set, mode)
            @run.macro_setstatus(@id, set, mode)
        end

        def get(mode)
            @run.macro_getstatus(@id, mode)
        end

        def state=(value)
            self.set(value, mode=1)
        end

        def state
            self.get(mode=1)
        end

        def stateonly=(value)
            self.set(value, mode=2)
        end
    
        def stateonly
            self.get(mode=2)
        end

        def trigger=(value)
            self.set(value, mode=3)
        end

        def trigger(set: nil)
            self.get(mode=3)        
        end
    end

    class Recorder < Alias
        def set(command, value = nil)
            command.chomp!('=')
            if value.nil?
                @run.set_parameter("recorder.#{command}", 1.0)
            else
                @run.set_parameter("recorder.#{command}", value)
            end
        end

        def play
            self.set(__method__.to_s)
        end

        def stop
            self.set(__method__.to_s)
        end

        def record
            self.set(__method__.to_s)
        end

        def ff
            self.set(__method__.to_s)
        end

        def rew
            self.set(__method__.to_s)
        end

        def A1=(value)
            self.set(__method__.to_s, value)
        end

        def A2=(value)
            self.set(__method__.to_s, value)
        end

        def A3=(value)
            self.set(__method__.to_s, value)
        end

        def A4=(value)
            self.set(__method__.to_s, value)
        end

        def A5=(value)
            self.set(__method__.to_s, value)
        end

        def B1=(value)
            self.set(__method__.to_s, value)
        end

        def B2=(value)
            self.set(__method__.to_s, value)
        end

        def B3=(value)
            self.set(__method__.to_s, value)
        end
    end

    class VBAN < Alias
        attr_accessor :id, :direction

        def id=(value)
            @id = value
        end

        def direction=(value)
            @direction = value
        end

        def initialize(run, index, dir)
            super(run)
            self.id = index
            self.direction = dir
        end

        def set(command, value)
            command.chomp!('=')
            if [false,true].include? value
                value = @run.bool_to_float(value)
            end
            @run.set_parameter("vban.#{@direction}stream[#{@id}].#{command}", value)
        end

        def enable=(value)
            self.set("on", value)
        end
    end
end
