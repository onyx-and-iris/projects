require './wrapper'
require 'toml'

class MACROS
    attr_accessor :cache, :config, :file_db

    def _initialize_cache
        if File.file?("#{@config}")
            puts "Loading from config file"
            @cache = (TOML.load_file("#{@config}"))
            puts @cache
        
        """ If no config set to base configuration """
        elsif File.file?("#{@file_db}")
            _load_cache
        end
        """ otherwise empty hash """
    end

    def _write_cache(name)
        """ Get param then write to cache """
        c_get = FFI::MemoryPointer.new(:float, 1)
        c_get.put_float(0, 0.0)

        VMR.get_paramF(name, c_get)
        oldval = c_get.get_float(0)

        VMR._clear_datapipe

        ret = VMR.get_paramF(name, c_get)

        if ret != 0
            puts "ERROR: CBF failed: #{ret}"
        end

        value = c_get.get_float(0).to_int

        @cache["#{name}"] = value
        
        File.open("cache.dat", "wb") do |f|
            f.write(Marshal.dump(@cache))
        end
    end

    def _load_cache(name = nil, full = 0)
        @cache = Marshal.load(File.binread(@file_db))

        if name != nil
            return @cache["#{name}"]
        elsif full
            return @cache
        end
    end

    def is_same?(param, value)
        """ if value in cache and same as set return early """
        if @cache.include? param
            if @cache[param] == value
                print "value in cache: #{@cache[param]}\n"
                return true
            end
        elsif VMR._get_parameter(param) == value
            "value returned by _get_parameter = #{value}\n"
            return true
        end
        print "returning false\n"
        return false
    end
end

#########################################

def run(param, value, button_ID=0)
    """ run some tests on the wrapper """
    macros = MACROS.new

    macros.cache = Hash(nil)
    macros.config = "myconfig.toml"
    macros.file_db = "cache.dat"

    puts "LOADING CACHE:"
    puts "============================="
    macros._initialize_cache
    puts "\n#{macros.cache}"

    VMR._special_command('Show')

    puts "Setting button [#{button_ID}] to 1"
    puts "=================================="
    VMR._macro_status(button_ID, value)

    sleep(1)

    puts "\nSetting button [#{button_ID}] to 0"
    puts "=================================="
    VMR._macro_status(button_ID, value)

    sleep(1)

    puts "\n\nSetting parameter #{param} to #{value}"
    puts "=================================="
    VMR._set_parameter(param, value)

    macros._write_cache(param)
    newvalue = macros._load_cache(param)
    puts "#{param} = #{newvalue}"

    sleep(1)

    puts "\nParameters set. STORING cache:\n"
    puts "================================="
    full_cache = macros._load_cache(nil, 1)
    puts "#{full_cache}\n"

    sleep(1)

    puts "\n\nShowing VBAN Chat"
    puts "================================="
    VMR._special_command('DialogShow.VBANCHAT')

    sleep(1)

    # only potato supports the recorder
    if VMR._vbType == 3
        VMR._recorder('play')
        sleep(20)
        VMR._recorder('stop')

        sleep(1)
    end
end

##############################################
# first run all 0
mute = [0, 0, 0, 0, 0]
gain = [0, 0, 0, 0, 0]

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

# second run all 1
mute.map! {|item| item += 1}

gain.map! {|item| item += 1}

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