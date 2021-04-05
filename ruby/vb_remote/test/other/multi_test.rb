require 'routines'

def macrostatus(vmr)
    """ 
    mute then unmute macrobuttons 
    set then get values
    """
    10.times do
        (0..5).each do |num|
            puts "Setting Macrobutton[#{num}]: on"
            vmr.macro_setstatus(num, ON)
            puts "New value: #{vmr.macro_getstatus(num)}"

            puts "Setting Macrobutton[#{num}]: off"
            vmr.macro_setstatus(num, OFF)
            puts "New value: #{vmr.macro_getstatus(num)}"
        end
    end
end

def setmutes(vmr)
    """ 
    mute then unmute strips
    test out of bounds values 
    """
    5.times do
        (0..8).each do |num|
            puts "Setting Strip[#{num}].mute: on"
            vmr.set_parameter("Strip[#{num}].mute", ON)

            puts "Setting Strip[#{num}].mute: off"
            vmr.set_parameter("Strip[#{num}].mute", OFF)
        end
        (0..8).each do |num|
            puts "Setting Bus[#{num}].mute: on"
            vmr.set_parameter("Bus[#{num}].mute", ON)

            puts "Setting Bus[#{num}].mute: off"
            vmr.set_parameter("Bus[#{num}].mute", OFF)
        end
    end
end

def setmono(vmr)
    """ 
    toggle mono for strips
    test out of bounds values 
    """
    5.times do
        (0..8).each do |num|
            puts "Setting Strip[#{num}].mono: on"
            vmr.set_parameter("Strip[#{num}].mono", ON)

            puts "Setting Strip[#{num}].mono: off"
            vmr.set_parameter("Strip[#{num}].mono", OFF)
        end
    end
end
 
def setsolo(vmr)
    """ 
    toggle solo for strips
    test out of bounds values 
    """
    10.times do
        (0..8).each do |num|
            puts "Setting Bus[#{num}].solo: on"
            vmr.set_parameter("Bus[#{num}].solo", ON)

            puts "Setting Bus[#{num}].solo: off"
            vmr.set_parameter("Bus[#{num}].solo", OFF)
        end
    end
end

def setgain(vmr)
    """ 
    toggle solo for strips
    test out of bounds values 
    """
    10.times do
        (0..8).each do |num|
            puts "Setting Bus[#{num}].gain: on"
            vmr.set_parameter("Bus[#{num}].gain", ON)

            puts "Setting Bus[#{num}].gain: off"
            vmr.set_parameter("Bus[#{num}].gain", OFF)
        end
    end
end

def setvban(vmr)
    """ 
    toggle vban in/oustreams, test out of bounds
    """
    (0..10).each do |num|
        puts "Setting vban.instream[#{num}].on: on"
        vmr.set_parameter("vban.instream[#{num}].on", ON)
        puts "Setting vban.instream[#{num}].on: off"
        vmr.set_parameter("vban.instream[#{num}].on", OFF)
    end

    (0..10).each do |num|
        puts "Setting vban.outstream[#{num}].on: on"
        vmr.set_parameter("vban.outstream[#{num}].on", ON)
        puts "Setting vban.outstream[#{num}].on: off"
        vmr.set_parameter("vban.outstream[#{num}].on", OFF)
    end
end

def setrevdel(vmr)
    5.times do
        """ toggle reverb/delay (potato only) """
        puts "Setting Fx.Reverb.On: on"
        vmr.set_parameter("Fx.Reverb.On", ON)
        puts "Setting Fx.Reverb.On: off"
        vmr.set_parameter("Fx.Reverb.On", OFF)

        puts "Setting Fx.Delay.On: on"
        vmr.set_parameter("Fx.Delay.On", ON)
        puts "Setting Fx.Delay.On: off"
        vmr.set_parameter("Fx.Delay.On", OFF)
    end
end

def setpatchinsert(vmr)
    """ 
    toggle patch inserts 
    test out of bounds
    """
    (0..40).each do |num|
        puts "Setting patch.insert[#{num}]: on"
        vmr.set_parameter("patch.insert[#{num}]", ON)
        puts "Setting patch.insert[#{num}]: off"
        vmr.set_parameter("patch.insert[#{num}]", OFF)

        puts "Setting patch.insert[#{num}]: on"
        vmr.set_parameter("patch.insert[#{num}]", ON)
        puts "Setting patch.insert[#{num}]: off"
        vmr.set_parameter("patch.insert[#{num}]", OFF)
    end
end

def getparams(vmr)
    """ mute then unmute strips """
    (0..2).each do |num|
        puts "Getting Strip[#{num}].mute"
        puts vmr.get_parameter("Strip[#{num}].mute")
        puts "Getting Strip[#{num}].gain"
        puts vmr.get_parameter("Strip[#{num}].gain")
        puts "Getting Strip[#{num}].A2"
        puts vmr.get_parameter("Strip[#{num}].A2")
    end
end

def getparams_loop(vmr)
    500.times do
        print "Strip Mutes = [%.0f] [%.0f] [%.0f]\n" \
        % [
            vmr.get_parameter("Strip[0].mute"),
            vmr.get_parameter("Strip[1].mute"),
            vmr.get_parameter("Strip[2].mute")
        ]
        sleep(DELAY)
    end
    500.times do
        print "Strip Gains = [%.1f] [%.1f] [%.1f]\n" \
        % [
            vmr.get_parameter("Strip[0].gain"),
            vmr.get_parameter("Strip[1].gain"),
            vmr.get_parameter("Strip[2].gain")
        ]
        sleep(DELAY)
    end
end

def special(vmr)
    """ 
    run a special command 
    options = 'Shutdown', 'Show', 'Restart',
    'Reset', 'DialogShow.VBANCHAT'
    """
    sleep(DELAY)
    puts "Running command Show"
    vmr.special_command("Show")
    sleep(DELAY)
    puts "Running command DialogShow.VBANCHAT"
    vmr.special_command("DialogShow.VBANCHAT")
end

def configs(vmr)
    """ Test load config special command """
    puts "Loading config test0.xml"
    vmr.special_command("Load",
    ".\\test0.xml")
    sleep(2)
    puts "Loading config test1.xml"
    vmr.special_command("Load",
    ".\\test1.xml")
    sleep(2)
    puts "Loading config test2.xml"
    vmr.special_command("Load",
    ".\\test2.xml")
end

def setparamstring(vmr)
    """ 
    get a string parameter eg Strip[0].name
    added out of bounds tests
    """
    puts "Setting Strip Label names test0"
    (0..8).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "testing[0]")
        sleep(DELAY)
    end
    puts "Setting Strip Label names test1"
    (0..8).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "testing[1]")
        sleep(DELAY)
    end
    puts "Setting Strip Label names reset"
    (0..8).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "reset")
        sleep(DELAY)
    end
end

def getparamstring(vmr)
    """ 
    get a string parameter eg Strip[0].device.name
    """
    (0..2).each do |num|
        puts vmr.get_parameter("Strip[#{num}].Label")
        puts vmr.get_parameter("Strip[#{num}].device.name")
    end
end

def setandgetparamstring(vmr)
    puts "Setting Strip Label names test0"
    (0..2).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "testing[0]")
        puts vmr.get_parameter("Strip[#{num}].Label")
    end
    puts "Setting Strip Label names test1"
    (0..2).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "testing[1]")
        puts vmr.get_parameter("Strip[#{num}].Label")
    end
    puts "Setting Strip Label names reset"
    (0..2).each do |num|
        vmr.set_parameter("Strip[#{num}].Label", "reset")
        puts vmr.get_parameter("Strip[#{num}].Label")
    end
end

def setparammulti(vmr)
    """ 
    set several parameters using a hash 
    test values out of range
    """
    10.times do
        param_hash = {
            :strip_1 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_2 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_3 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_4 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_5 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_6 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_7 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_8 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_9 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :strip_10 => {"mute" => ON, "gain" => ON, "A2" => ON},
            :bus_1 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_2 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_3 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_4 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_5 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_6 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_12 => {"mute" => ON, "gain" => ON, "mono" => ON},
            :bus_15 => {"mute" => ON, "gain" => ON, "mono" => ON}
        }
        puts "Running multi parameter set"
        vmr.set_parameter_multi(param_hash)

        param_hash.each do |key, index|
            index.each do |k, v|
                param_hash[key][k] = OFF
            end
        end
        puts "Running multi parameter unset"
        vmr.set_parameter_multi(param_hash)
    end
end

def setandget(vmr)
    (1..30).each do |num|
        puts "Set then get Strip[0].gain to -#{num}"
        vmr.set_parameter("Strip[0].gain", -num)
        puts vmr.get_parameter("Strip[0].gain")
    end
    puts "Reset Strip[0].gain"
    vmr.set_parameter("Strip[0].gain", 0)
    puts vmr.get_parameter("Strip[0].gain")
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

def cbf_error(vmr)
    vmr.get_parameter("GARBAGEVALUE")
end

def lid_error(vmr)
    (90..99).each do |num|
        puts "Setting Macrobutton[#{num}]: on"
        vmr.macro_setstatus(num, ON)
        puts vmr.macro_getstatus(num)

        puts "Setting Macrobutton[#{num}]: off"
        vmr.macro_setstatus(num, OFF)
        puts vmr.macro_getstatus(num)
    end
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

    ON = 1
    OFF = 0
    DELAY = 0.02

    if args.empty?
        puts "Running multiple tests"
        vmr.run do
            macrostatus(vmr)
            setvban(vmr)
            setmutes(vmr)
            getparams(vmr)
            special(vmr)
            setparamstring(vmr)
            getparamstring(vmr)
            setparammulti(vmr)
            setrevdel(vmr)
            
            """ Testing from vmr.run """
            (0..2).each do |num|
                puts "Getting Strip[#{num}] Label and device.name"
                puts vmr.get_parameter("Strip[#{num}].Label")
                puts vmr.get_parameter("Strip[#{num}].device.name")
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
    elsif args.include? "revdel"
        puts "Running reverb/delay test"
        vmr.run do
            setrevdel(vmr)
        end
    elsif args.include? "pinsert"
        puts "Running patch insert test"
        vmr.run do
            setpatchinsert(vmr)
        end
    elsif args.include? "cbferr"
        puts "Running Callback Function error test (expected -3)"
        vmr.run do
            cbf_error(vmr)
        end
    elsif args.include? "liderr"
        puts "Running Logical ID bounds error test"
        vmr.run do
            lid_error(vmr)
        end
    elsif args.include? "conf"
        puts "Running load configs test "
        vmr.run do
            configs(vmr)
        end
    else
        vmr.run do
            simpletest(args, vmr)
        end
    end
end
