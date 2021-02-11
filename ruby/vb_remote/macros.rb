require 'ffi'
require 'toml'

module VMR
    dll = ['C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll']
    extend FFI::Library

    ffi_lib dll
    ffi_convention :stdcall

    # login/logout routines
    attach_function :login, :VBVMR_Login, [], :int
    attach_function :logout, :VBVMR_Logout, [], :int
    attach_function :run, :VBVMR_RunVoicemeeter, [:int], :int
    attach_function :getType, :VBVMR_GetVoicemeeterType, [:pointer], :int

    # macro buttons
    attach_function :macro_isDirty, :VBVMR_MacroButton_IsDirty, [], :int
    attach_function :macro_setStatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long

    
    # set/get params
    attach_function :set_paramF, :VBVMR_SetParameterFloat, [:string, :float], :int
    attach_function :get_paramF, :VBVMR_GetParameterFloat, [:string, :pointer], :int
    attach_function :param_isDirty, :VBVMR_IsParametersDirty, [], :int

    @cache = Hash(nil)
    @config = "myconfig.toml"

    class << self
        attr_accessor :cache
        attr_accessor :config

        def _initialize_cache
            if File.file?(VMR.config)
                puts "Loading from config file"
                VMR.cache = (TOML.load_file(VMR.config))
                puts VMR.cache
            end
            """ If no config set to base configuration """
        end

        def _save_config

        end


        def _clear_datapipe
            """ Poll param_isDirty until pipe is clear """
            while param_isDirty !=0 do
            end
        end

        def _vbType
            """ get voicemeter version 1 = basic, 2 = banana, 3 = potato """
            c_get = FFI::MemoryPointer.new(:int, 1)
            c_get.put_long(0, 0)

            ret = getType(c_get)
 
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            else
                return c_get.get_long(0)
            end
            
        end

        def _login
            """ remote login, get vb type, clear datpipe and initialize cache """
            success = login

            if success < 0
                exit(false)
            end

            type = _vbType
            puts "VB type is #{type}"

            _clear_datapipe

            _initialize_cache
        end
        
        def _macro_status(logical_id, state, mode=2)
            """ nulogical, state, mode """
            puts "Button#{logical_id} = #{state}"
            ret = macro_setStatus(logical_id, state.to_f, mode)

            _clear_datapipe
            
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end
        end

        def _set_parameter(name, set)
            """ VBVMR_SetParameterFloat """
            c_get_old = FFI::MemoryPointer.new(:float, 1)
            c_get_new = FFI::MemoryPointer.new(:float, 1)

            get_paramF(name, c_get_old)
            oldval = c_get_old.get_float(0)

            while true do
                set_paramF(name, set.to_f)
                get_paramF(name, c_get_new)
                newval = c_get_new.get_float(0)
                  
                break if oldval != newval

                _clear_datapipe
            end

            get_paramF(name, c_get_new)
            newval = c_get_new.get_float(0)
        end
        
        def _write_cache(name)
            """ Get param then write to cache """
            c_get = FFI::MemoryPointer.new(:float, 1)
            c_get.put_float(0, 0.0)

            get_paramF(name, c_get)
            oldval = c_get.get_float(0)

            _clear_datapipe

            ret = get_paramF(name, c_get)

            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end

            value = c_get.get_float(0).to_int


            VMR.cache["#{name}"] = value
            
            File.open("cache.dat", "wb") do |f|
                f.write(Marshal.dump(VMR.cache))
            end
        end

        def _load_cache(name = nil, full = 0)
            VMR.cache = Marshal.load(File.binread("cache.dat"))

            if name != nil
                return VMR.cache["#{name}"]
            elsif full
                return VMR.cache
            end
        end
 
        def _special_command(name)
            _value = 1

            if ['Shutdown', 'Show', 'Restart', -
                 'Reset', 'DialogShow.VBANCHAT'].include? name
                _command = 'Command.' + name
            else
                puts "Command not available!"
            end

            ret = set_paramF(_command, _value)
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end
        end

        def _recorder(name, value=1)
            _command = 'recorder.' + name
            _value = value.to_f
            ret = set_paramF(_command, _value)
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end
        end

        def _logout
            logout
        end
    end
end


#########################################
param = "Strip[1].mute"
button_ID = 0

VMR._login

VMR._special_command('Show')

puts "Setting button [#{button_ID}] to 1"
puts "=================================="
VMR._macro_status(button_ID, 1)

sleep(1)

puts "\nSetting button [#{button_ID}] to 0"
puts "=================================="
VMR._macro_status(button_ID, 0)

sleep(1)

puts "\n\nSetting parameter #{param} to 1"
puts "=================================="
VMR._set_parameter(param, 1)
VMR._write_cache(param)
newvalue = VMR._load_cache(param)
puts "#{param} = #{newvalue}"

sleep(1)

puts "Setting parameter #{param} to 0"
puts "================================="
VMR._set_parameter(param, 0)
VMR._write_cache(param)
newvalue = VMR._load_cache(param)
puts "#{param} = #{newvalue}"

sleep(1)

puts "\nParameters set. Current cache:\n"
puts "================================="
full_cache = VMR._load_cache(nil, 1)
puts "#{full_cache}"

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

puts "\n\nSave settings to config"
puts "================================="
VMR._save_config

VMR._logout


=begin
    note _get_parameter working reliably if value set 
    in script but not if change in GUI
    special commands are readonly

    name.gsub(/[\[|\]]/, "|")
=end