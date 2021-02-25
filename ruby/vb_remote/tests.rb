require_relative 'wrapper'

def macrostatus(vmr)
    """ mute then unmute macrobuttons 0 to 9 """
    (0..9).each do |num|
        puts "Setting Macrobutton[#{num}]: on"
        vmr.macro_status(num, ON)
        sleep(0.5)
        puts "Setting Macrobutton[#{num}]: off"
        vmr.macro_status(num, OFF)
        sleep(0.5)
    end
end

def setmutes(vmr)
    """ mute then unmute strip 0 to 3 """
    (0..2).each do |num|
        puts "Setting Strip[#{num}].mute: on"
        vmr.set_parameter("Strip[#{num}].mute", ON)
        sleep(0.5)
        puts "Setting Strip[#{num}].mute: off"
        vmr.set_parameter("Strip[#{num}].mute", OFF)
        sleep(0.5)
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
    (0..2).each do |num|
        vmr.set_parameter_string("Strip[#{num}].Label", "testing[0]")
        sleep(1)
    end
    (0..2).each do |num|
        vmr.set_parameter_string("Strip[#{num}].Label", "testing[1]")
        sleep(1)
    end
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
    """ set several parameters using a hash """
    param_hash = Hash.new
    switch = false
    param_hash = {
        :strip_0 => {"mute" => OFF, "gain" => OFF},
        :strip_1 => {"mute" => OFF, "gain" => OFF},
        :strip_2 => {"mute" => OFF, "gain" => OFF}
    }

    if switch
        param_hash.each do |key, index|
            index.each do |k, v|
                param_hash[key][k] = ON
            end
        end
    end
    sleep(0.5)
    vmr.set_parameter_multi(param_hash)
end

def recorder(vmr)
    vmr.recorder_command("record")
    sleep(10)
    vmr.recorder_command("stop")
    sleep(1)
    vmr.recorder_command("play")
    sleep(10)
    vmr.recorder_command("stop")
end

def simpletest(args, vmr)
    """ build eval string to invoke test run for each arg variable """
    args.each { |func| method = func.to_s; eval("#{method}(vmr)") }
end

if __FILE__ == $PROGRAM_NAME
    """ 
    Run every test if no arg
    Otherwise run test requested
    """
    args = ARGV
    vmr = Remote.new

    ON = 1
    OFF = 0

    if args.empty?
        vmr.run do
            macrostatus(vmr)
            setmutes(vmr)
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
    else
        vmr.run do
            simpletest(args, vmr)
        end
    end
end
