require 'ffi'

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


    class << self
        def _login
            """ login then run: 1 = basic, 2 = banana, 3 = potato """
            success = login

            if success < 0
                exit(false)
            end

            type = self._vbType
            puts "VB type is #{type}"
        end
        
        def _vbType
            c_get = FFI::MemoryPointer.new(:int, 1)
            c_get.put_long(0, 0)

            ret = getType(c_get)
 
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            else
                return c_get.get_long(0)
            end
            
        end
        
        def _macro_status(logical_id, state, mode=2)
            """ nulogical, state, mode """
            puts "Button#{logical_id} = #{state}"
            ret = macro_setStatus(logical_id, state.to_f, mode)
            while macro_isDirty != 0 do
                sleep(0.015)
            end
            
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end
        end

        def _set_parameter(name, set)
            """ VBVMR_SetParameterFloat """
            oldval = _get_parameter(name)

            ret = set_paramF(name, set.to_f)

            while true
                newval = _get_parameter(name)
                break if oldval != newval
                sleep(0.015)
            end

            while param_isDirty !=0
                sleep(0.015)
            end

            ret = set_paramF(name, set.to_f)
            if ret != 0
                puts "here"
                puts "ERROR: CBF failed: #{ret}"
            end
        end
        
        def _get_parameter(name)
            """ VBVMR_GetParameterFloat """
            c_get = FFI::MemoryPointer.new(:float, 1)
            c_get.put_float(0, 0.0)

            get_paramF(name, c_get)
            oldval = c_get.get_float(0)
            while param_isDirty != 0
                sleep(0.015)
            end
            ret = get_paramF(name, c_get)

            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end

            value = c_get.get_float(0).to_int

            return value
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

param = "Strip[0].mute"
button_ID = 0

VMR._login

VMR._special_command('Show')

puts "Setting button [#{button_ID}] to 1"
puts "=================================="
VMR._macro_status(button_ID, 1)

sleep(1)

puts "Setting button [#{button_ID}] to 0"
puts "=================================="
VMR._macro_status(button_ID, 0)

sleep(1)

puts "\n\nSetting parameter #{param} to 1"
puts "=================================="
VMR._set_parameter(param, 1)
newvalue = VMR._get_parameter(param)
puts "#{param} = #{newvalue}"

sleep(1)

puts "Setting parameter #{param} to 0"
puts "================================="
VMR._set_parameter(param, 0)
newvalue = VMR._get_parameter(param)
puts "#{param} = #{newvalue}"

sleep(1)

# only potato supports the recorder
if VMR._vbType == 3
    VMR._recorder('play')
    sleep(20)
    VMR._recorder('stop')

    sleep(1)
end

VMR._logout



# note _get_parameter working reliably if value set 
# in script but not if change in GUI