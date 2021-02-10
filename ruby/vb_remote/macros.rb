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

    # macro buttons
    attach_function :macro_isDirty, :VBVMR_MacroButton_IsDirty, [], :int
    attach_function :macro_setStatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long
    
    # set/get params
    attach_function :param_isDirty, :VBVMR_IsParametersDirty, [], :int
    attach_function :get_paramF, :VBVMR_GetParameterFloat, [:string, :pointer], :int
    attach_function :set_paramF, :VBVMR_SetParameterFloat, [:string, :float], :int


    class << self
        def _login
            """ login then logout and reset parameters """
            login
            run(2)
            VMR.param_isDirty
        end
        
        def _macro_status(logical_id, state, mode=2)
            """ nulogical, state, mode """
            ret = VMR.macro_isDirty
            puts "return of macro_isDirty: #{ret}"
            while TRUE do
                VMR.macro_setStatus(logical_id, state.to_f, mode)
                newval = VMR.macro_isDirty
                puts "return of newval: #{ret}"
                break if newval != ret
                sleep(0.015)
            end
        end

        def _get_parameter(name)
            """ VBVMR_GetParameterFloat """
            c_get = FFI::MemoryPointer.new(:float, 1)

            while VMR.param_isDirty > 0
                sleep(0.015)
            end

            ret = VMR.get_paramF(name, c_get)
            if ret != 0
                puts "ERROR: CBF failed: #{ret}"
            end

            value = c_get.get_float(0).to_int

            return value
        end

        def _set_parameter(name, set)
            """ VBVMR_SetParameterFloat """
            ret = VMR.set_paramF(name, set.to_f)

            while VMR.param_isDirty > 0
                sleep(0.015)
            end

            ret = VMR.set_paramF(name, set.to_f)
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

VMR._login

####### WORKING #########
"""
VMR._macro_status(0, 1)
sleep(1)
VMR._macro_status(0, 0)
sleep(3)
"""

VMR._set_parameter(param, 1)
newvalue = VMR._get_parameter(param)
puts "value of #{param} = #{newvalue}"

puts "sleeping 1 seconds..."
sleep(1)

VMR._set_parameter(param, 0)
newvalue = VMR._get_parameter(param)
puts "value of #{param} = #{newvalue}"

VMR._logout
