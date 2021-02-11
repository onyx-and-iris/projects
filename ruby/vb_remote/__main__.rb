require './macros'

def run(param, value, button_ID=0)
    #VMR._login

    VMR._special_command('Show')
=begin
    puts "Setting button [#{button_ID}] to 1"
    puts "=================================="
    VMR._macro_status(button_ID, value)

    sleep(1)

    puts "\nSetting button [#{button_ID}] to 0"
    puts "=================================="
    VMR._macro_status(button_ID, value)
=end
    sleep(1)

    puts "\n\nSetting parameter #{param} to #{value}"
    puts "=================================="
    VMR._set_parameter(param, value)
    VMR._write_cache(param)
    newvalue = VMR._load_cache(param)
    puts "#{param} = #{newvalue}"

    sleep(1)
=begin
    puts "Setting parameter #{param} to #{value}"
    puts "================================="
    VMR._set_parameter(param, 0)
    VMR._write_cache(param)
    newvalue = VMR._load_cache(param)
    puts "#{param} = #{newvalue}"

    sleep(1)
=end
    puts "\nParameters set. Current cache:\n"
    puts "================================="
    full_cache = VMR._load_cache(nil, 1)
    puts "#{full_cache}"

    sleep(1)
=begin
    puts "\n\nShowing VBAN Chat"
    puts "================================="
    VMR._special_command('DialogShow.VBANCHAT')

    sleep(1)
=end
    # only potato supports the recorder
    if VMR._vbType == 3
        VMR._recorder('play')
        sleep(20)
        VMR._recorder('stop')

        sleep(1)
    end

    puts "\n\nSave settings to config"
    puts "================================="

    #VMR._logout

end

#########################################
mute = [0, 0, 0, 0, 1]
gain = [0, 0, 0, 0, 1]

=begin
mute.map! {|item| item += 1}
puts mute
gain.map! {|item| item += 1}
puts gain
=end

VMR._login

run("Strip[0].mute", mute[0])
run("Strip[1].mute", mute[1])
run("Strip[2].mute", mute[2])
run("Strip[3].mute", mute[3])
run("Strip[4].mute", mute[4])

run("Strip[0].gain", gain[0])
run("Strip[1].gain", gain[1])
run("Strip[2].gain", gain[2])
run("Strip[3].gain", gain[3])
run("Strip[4].gain", gain[4])

VMR._logout


=begin
    note _get_parameter working reliably if value set 
    in script but not if change in GUI
    special commands are readonly

    name.gsub(/[\[|\]]/, "|")
=end