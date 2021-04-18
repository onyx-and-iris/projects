require 'ffi'
require_relative 'inst'

module FunctionHooks
    extend FFI::Library

    attr_reader :vmr_dll, :os_bits, :setdelay, :getdelay

    if ((@os_bits = get_arch) == 64)
        dll_name = "VoicemeeterRemote64.dll"
    elsif @os_bits == 32
        dll_name = "VoicemeeterRemote.dll"
    end

    begin
        self.vmr_dll = get_vbpath.join(dll_name)
    rescue DLLNotFoundError => error
        puts "ERROR: #{error.message}"
        raise
    end

    ffi_lib @vmr_dll
    ffi_convention :stdcall

    attach_function :vmr_login, :VBVMR_Login, [], :long
    attach_function :vmr_logout, :VBVMR_Logout, [], :long
    attach_function :vmr_runvb, :VBVMR_RunVoicemeeter, [:long], :long
    attach_function :vmr_vbtype, :VBVMR_GetVoicemeeterType, [:pointer], :long

    attach_function :vmr_mdirty, :VBVMR_MacroButton_IsDirty, [], :long
    attach_function :vmr_macro_setstatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long
    attach_function :vmr_macro_getstatus, :VBVMR_MacroButton_GetStatus, \
    [:long, :pointer, :long], :long

    attach_function :vmr_pdirty, :VBVMR_IsParametersDirty, [], :long
    attach_function :vmr_set_parameter_float, :VBVMR_SetParameterFloat, \
    [:string, :float], :long
    attach_function :vmr_get_parameter_float, :VBVMR_GetParameterFloat, \
    [:string, :pointer], :long

    attach_function :vmr_set_parameter_string, :VBVMR_SetParameterStringA, \
    [:string, :string], :long
    attach_function :vmr_get_parameter_string, :VBVMR_GetParameterStringA, \
    [:string, :pointer], :long

    attach_function :vmr_set_parameter_multi, :VBVMR_SetParameters, \
    [:string], :long

    ACCESSOR_DELAY = 0.001
    RUNDELAY = 1

    """ Timer functions """
    def setdelay=(value)
        @setdelay = value
    end

    def getdelay=(value)
        @getdelay = value
    end

    def rundelay=(value)
        @rundelay = value
    end

    def clear_pdirty
        while vmr_pdirty&.nonzero?
        end
    end

    def wait_pdirty
        until vmr_pdirty&.nonzero?
        end
    end

    def clear_mdirty
        while vmr_mdirty&.nonzero?
        end
    end

    def wait_mdirty
        until vmr_mdirty&.nonzero?
        end
    end

    def run_as(func, *args)
        torun = 'vmr_' + func.to_s
        val = send(torun, *args)

        sleep(@setdelay) if torun.include? 'set_'
        sleep(@getdelay) if torun.include? 'get_'
        val
    end
end
