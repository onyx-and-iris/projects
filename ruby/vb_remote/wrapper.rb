require 'ffi'

module VMR_API
    """ import dll and register hooks to C API. Define timer functions """
    dll = ['C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll']
    extend FFI::Library

    ffi_lib dll
    ffi_convention :stdcall

    attach_function :login, :VBVMR_Login, [], :long
    attach_function :logout, :VBVMR_Logout, [], :long
    attach_function :run_vb, :VBVMR_RunVoicemeeter, [:long], :long
    attach_function :get_type, :VBVMR_GetVoicemeeterType, [:pointer], :long

    attach_function :macro_isdirty, :VBVMR_MacroButton_IsDirty, [], :long
    attach_function :macro_setstatus, :VBVMR_MacroButton_SetStatus, \
    [:long, :float, :long], :long
    attach_function :macro_getstatus, :VBVMR_MacroButton_GetStatus, \
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

module STRIPS
    attr_reader :strip_layout

    BASIC = 1
    BANANA = 2
    POTATO = 3

    def strip_layout=(value)
        @strip_layout = value
    end

    def build_strips(type)
        self.strip_layout =  {
            :strip => {:p_in => 0, :v_in => 0, :p_out => 0, :v_out => 0}, 
            :in_vban => 0, 
            :out_vban => 0
        }    

        if type == BASIC
            factory([2, 1, 2, 2, 4])
        elsif type == BANANA
            factory([3, 2, 3, 2, 8])
        elsif type == POTATO
            factory([5, 3, 5, 3, 8])
        end
    end

    def factory(values)
        num = 0

        @strip_layout.each do |key, val|
            unless @strip_layout[key] && @strip_layout[key][val]
                val.each do |k, v|
                    @strip_layout[key][k] = values[num]
                    num += 1
                end
            end
        end
        @strip_layout[:in_vban] = values[num]
        @strip_layout[:out_vban] = values[num]
    end
end
