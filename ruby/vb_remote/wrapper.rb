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

    
    # set/get params float
    attach_function :param_isDirty, :VBVMR_IsParametersDirty, [], :int
    attach_function :set_paramF, :VBVMR_SetParameterFloat, [:string, :float], :int
    attach_function :get_paramF, :VBVMR_GetParameterFloat, [:string, :pointer], :int

    # set/get params string

    class << self
        def _clear_datapipe
            """ Poll param_isDirty until pipe is clear """
            until param_isDirty == 0 do
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
                c_get.get_long(0)
            end
        end

        def _login
            """ remote login, get vb type, clear datpipe and initialize cache """
            success = login

            if success < 0
                exit(false)
            end

            type = _vbType

            _clear_datapipe
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
            """ Otherwise... VBVMR_SetParameterFloat """
            c_get_old = FFI::MemoryPointer.new(:float, 1)
            c_get_new = FFI::MemoryPointer.new(:float, 1)

            get_paramF(name, c_get_old)
            oldval = c_get_old.get_float(0)
            if oldval != set
                while true do
                    set_paramF(name, set.to_f)
                    get_paramF(name, c_get_new)
                    newval = c_get_new.get_float(0)

                    _clear_datapipe
                    
                    break if oldval != newval
                end
            end
            
            get_paramF(name, c_get_new)
            newval = c_get_new.get_float(0)
        end

        def _get_parameter(name)
            c_get = FFI::MemoryPointer.new(:float, 1)

            _clear_datapipe
            
            get_paramF(name, c_get)
            val = c_get.get_float(0)
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