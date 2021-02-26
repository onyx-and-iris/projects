require_relative 'routines'

def macrostatus(vmr)
    """ mute then unmute macrobuttons """
    (0..2).each do |num|
        puts "Setting Macrobutton[#{num}]: on"
        vmr.macro_status(num, ON)
        sleep(0.5)
        puts "Setting Macrobutton[#{num}]: off"
        vmr.macro_status(num, OFF)
        sleep(0.5)
    end
end

def setmutes(vmr)
    """ mute then unmute strips"""
    (0..8).each do |num|
        puts "Setting Strip[#{num}].mute: on"
        vmr.set_parameter("Strip[#{num}].mute", ON)
        sleep(0.5)
        puts "Setting Strip[#{num}].mute: off"
        vmr.set_parameter("Strip[#{num}].mute", OFF)
        sleep(0.5)
    end
    (0..8).each do |num|
        puts "Setting Bus[#{num}].mute: on"
        vmr.set_parameter("Bus[#{num}].mute", ON)
        sleep(0.5)
        puts "Setting Bus[#{num}].mute: off"
        vmr.set_parameter("Bus[#{num}].mute", OFF)
        sleep(0.5)
    end
end

def getparams(vmr)
    """ mute then unmute strips """
    (0..2).each do |num|
        puts "Getting Strip[#{num}].mute"
        puts vmr.get_parameter("Strip[#{num}].mute")
        sleep(0.5)
        puts "Getting Strip[#{num}].gain"
        puts vmr.get_parameter("Strip[#{num}].gain")
    end
end

def getparams_loop(vmr)
    100.times do
        print "Strip Mutes = [%.0f] [%.0f] [%.0f]\n" \
        % [
            vmr.get_parameter("Strip[0].mute"),
            vmr.get_parameter("Strip[1].mute"),
            vmr.get_parameter("Strip[2].mute")
        ]
        sleep(0.2)
    end
    100.times do
        print "Strip Gains = [%.1f] [%.1f] [%.1f]\n" \
        % [
            vmr.get_parameter("Strip[0].gain"),
            vmr.get_parameter("Strip[1].gain"),
            vmr.get_parameter("Strip[2].gain")
        ]
        sleep(0.2)
    end
end

def special(vmr)
    """ 
    run a special command 
    options = 'Shutdown', 'Show', 'Restart',
    'Reset', 'DialogShow.VBANCHAT'
    """
    sleep(1)
    puts "Running command Show"
    vmr.special_command("Show")
    sleep(1)
    puts "Running command DialogShow.VBANCHAT"
    vmr.special_command("DialogShow.VBANCHAT")
end

def setparamstring(vmr)
    """ 
    get a string parameter eg Strip[0].name
    """
    puts "Setting Strip Label names test0"
    (0..2).each do |num|
        vmr.set_parameter_string("Strip[#{num}].Label", "testing[0]")
        sleep(1)
    end
    puts "Setting Strip Label names test1"
    (0..2).each do |num|
        vmr.set_parameter_string("Strip[#{num}].Label", "testing[1]")
        sleep(1)
    end
    puts "Setting Strip Label names reset"
    (0..2).each do |num|
        vmr.set_parameter_string("Strip[#{num}].Label", "reset")
        sleep(1)
    end
end

def getparamstring(vmr)
    """ 
    get a string parameter eg Strip[0].name
    """
    (0..2).each do |num|
        vmr.get_parameter_string("Strip[#{num}].Label")
        vmr.get_parameter_string("Strip[#{num}].device.name")
        sleep(1)
    end
end

def setparammulti(vmr)
    """ 
    set several parameters using a hash 
    test values out of range
    """
    param_hash = Hash.new

    param_hash = {
        :strip_1 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_2 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_3 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_4 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_5 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_6 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_7 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_8 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_9 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :strip_10 => {"mute" => ON, "gain" => ON, "A1" => ON},
        :bus_1 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_2 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_3 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_12 => {"mute" => ON, "gain" => ON, "mono" => ON},
        :bus_15 => {"mute" => ON, "gain" => ON, "mono" => ON}
    }
    puts "Running multi parameter set"
    vmr.set_parameter_multi(param_hash)

    sleep(1)

    param_hash.each do |key, index|
        index.each do |k, v|
            param_hash[key][k] = OFF
        end
    end
    puts "Running multi parameter unset"
    vmr.set_parameter_multi(param_hash)
end

def recorder(vmr)
    puts "RECORDING"
    vmr.recorder_command("record")
    sleep(10)
    puts "STOP"
    vmr.recorder_command("stop")
    sleep(1)
    puts "PLAY"
    vmr.recorder_command("play")
    sleep(5)
    puts "STOP"
    vmr.recorder_command("stop")
    sleep(1)
end

def simpletest(args, vmr)
    """ build eval string to invoke test run for each arg variable """
    args.each { |func| method = func.to_s; eval("#{method}(vmr)") }
end

if __FILE__ == $PROGRAM_NAME
    """ 
    Run every test listed if no arg
    Otherwise run any test(s) requested as argument variables.
    """
    args = ARGV
    vmr = Remote.new
    puts args

    ON = 1
    OFF = 0

    if args.empty?
        puts "Running multiple tests"
        vmr.run do
            macrostatus(vmr)
            setmutes(vmr)
            getparams(vmr)
            special(vmr)
            setparamstring(vmr)
            getparamstring(vmr)
            setparammulti(vmr)
            
            """ Testing from vmr.run """
            (0..2).each do |num|
                vmr.get_parameter_string("Strip[#{num}].Label")
                vmr.get_parameter_string("Strip[#{num}].device.name")
                sleep(1)
            end
        end
    elsif args.include? "loop"
        puts "Running loop test"
        vmr.run do
            getparams_loop(vmr)
        end
    elsif args.include? "recorder"
        puts "Running recorder test"
        vmr.run do
            recorder(vmr)
        end
    elsif args.include? "strips"
        puts "Running strips test"
        vmr.run do
        end
    else
        vmr.run do
            simpletest(args, vmr)
        end
    end
end
