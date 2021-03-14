require 'ffi'
require_relative 'inst'

module WrapperBase
    extend FFI::Library

    attr_reader :vmr_dll
    
    DELAY = 0.02

    if ((os_bits = get_arch) == 64)
        dll_name = "VoicemeeterRemote64.dll"
    elsif os_bits == 32
        dll_name = "VoicemeeterRemote.dll"
    end

    begin
        self.vmr_dll = get_vbpath.join(dll_name) 
    rescue NoMethodError, DLLNotFoundError => error
        puts "ERROR: #{error.message}"
        exit(false)
    end

    ffi_lib @vmr_dll
    ffi_convention :stdcall

    attach_function :login, :VBVMR_Login, [], :long
    attach_function :logout, :VBVMR_Logout, [], :long
    attach_function :run_vb, :VBVMR_RunVoicemeeter, [:long], :long
    attach_function :get_type, :VBVMR_GetVoicemeeterType, [:pointer], :long

    attach_function :macro_isdirty, :VBVMR_MacroButton_IsDirty, [], :long
    attach_function :macrobutton_setstatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long
    attach_function :macrobutton_getstatus, :VBVMR_MacroButton_GetStatus, \
    [:long, :pointer, :long], :long

    attach_function :param_isdirty, :VBVMR_IsParametersDirty, [], :long
    attach_function :set_paramfloat, :VBVMR_SetParameterFloat, \
    [:string, :float], :long
    attach_function :get_paramfloat, :VBVMR_GetParameterFloat, \
    [:string, :pointer], :long

    attach_function :set_paramstring, :VBVMR_SetParameterStringA, \
    [:string, :string], :long
    attach_function :get_paramstring, :VBVMR_GetParameterStringA, \
    [:string, :pointer], :long

    attach_function :set_parammulti, :VBVMR_SetParameters, \
    [:string], :long

    """ Timer functions """
    def clear_pdirty
        while param_isdirty&.nonzero?
        end
    end

    def wait_pdirty
        until param_isdirty&.nonzero?
        end
    end

    def clear_mdirty
        while macro_isdirty&.nonzero?
        end
    end

    def wait_mdirty
        until macro_isdirty&.nonzero?
        end
    end
end
