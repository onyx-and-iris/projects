module Alias
    attr_reader :recorder, :button, :vban, :vban_in, :vban_out, :command

    def recorder=(value)
        @recorder = value
    end

    def command=(value)
        @command = value
    end

    def button=(value)
        @button = value
    end

    def vban=(value)
        if [false,true].include? value
            value = bool_to_float(value)
        end
        set_parameter("vban.Enable", value)
    end

    def vban(value)
        self.vban = value
    end

    def vban_in=(value)
        @vban_in = value
    end

    def vban_out=(value)
        @vban_out = value
    end

    def set_multi(value)
        set_parameter_multi(value)
    end

    def alias_factory
        self.recorder = Recorder.new(self)
        self.command = Command.new(self)

        self.button = []
        (1..70).each_with_index do |num, index|
            num = index if @base_0
            @button[num] = Macrobutton.new(self, index)
        end

        self.vban_in = []
        (1..@layout[:in_vban]).each_with_index do |num, index|
            num = index if @base_0
            @vban_in[num] = Vban.new(self, index, "in")
        end
        self.vban_out = []
        (1..@layout[:out_vban]).each_with_index do |num, index|
            num = index if @base_0
            @vban_out[num] = Vban.new(self, index, "out")
        end
    end

    class Alias
        include Make_Accessors
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
            self.make_accessor_buttons :state, :stateonly, :trigger
        end

        def setter(set, mode)
            raise BaseErrors::ValueTypeError.new(set,'bool') unless @run.is_a_bool?(set)
            if [false,true].include? set
                set = @run.bool_to_float(set)
            end
            @run.macro_setstatus(@id, set, mode)
        rescue BaseErrors => error
            puts "#{error.class}: #{error.message} in #{__callee__}"
            raise
        end

        def getter(mode)
            return !@run.macro_getstatus(@id, mode).zero?
        end
    end

    class Recorder < Alias
        def initialize(run)
            super
            self.make_accessor_bool :A1, :A2, :A3, :A4, :A5, :B1, :B2, :B3
            self.make_setter_action :play, :stop, :record, :ff, :rew
        end

        def setter(command, value = nil)
            command.chomp!('=')
            raise BaseErrors::ValueTypeError.new(value,'bool') unless @run.is_a_bool?(value)
            if [false,true].include? value
                value = @run.bool_to_float(value)
            end
            if value
                @run.set_parameter("recorder.#{command}", value)
            else
                @run.set_parameter("recorder.#{command}", 1.0)
            end
        rescue BaseErrors => error
            puts "#{error.class}: #{error.message} in #{__callee__}"
            raise
        end

        def getter(command)
            return !@run.get_parameter("recorder.#{command}").zero?
        end
    end

    class Vban < Alias
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
            self.make_accessor_bool :on
            self.make_accessor_standard :name, :ip, :port, :quality, :route
            self.make_accessor_in_is_readonly :sr, :channel, :bit
        end

        def setter(command, value)
            command.chomp!('=')
            if [false,true].include? value
                value = @run.bool_to_float(value)
            end
            @run.set_parameter("vban.#{@direction}stream[#{@id}].#{command}", value)
        end

        def getter(command)
            if @run.is_bool.include? command
                val = @run.get_parameter("vban.#{@direction}stream[#{@id}].#{command}")
                return !val.zero?
            end
            @run.get_parameter("vban.#{@direction}stream[#{@id}].#{command}")
        end
    end

    class Command < Alias
        def initialize(run)
            super
            self.make_setter_action :show, :restart, :eject, :reset
        end

        def setter(command, value = nil, delay = @run.saveloaddelay)
            command.chomp!('=')
            command[0] = command[0].capitalize
            @run.sp_command = command
            if value.nil?
                @run.set_parameter(@run.sp_command, 1.0)
            else
                @run.sp_value = value
                @run.set_parameter(@run.sp_command, @run.sp_value)
                sleep(delay)
            end
        end

        def shutdown
            self.setter(__method__.to_s)
            sleep(@run.shutdowndelay)
        end

        def save(value, delay = @run.saveloaddelay)
            self.setter(__method__.to_s, value, delay)
        end

        def load(value, delay = @run.saveloaddelay)
            self.setter(__method__.to_s, value, delay)
        end

        def showvbanchat
            self.setter("DialogShow.VBANCHAT")
        end
    end
end
