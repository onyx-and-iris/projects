require 'ffi'
require 'pathname'

module HOOKS
    extend FFI::Library

    attr_reader :vmr_dll

    dll_name = "VoicemeeterRemote64.dll"
    pn = Pathname.new("C:\\Program Files (x86)\\VB\\Voicemeeter\\")
    pn = pn.join(dll_name)

    if pn.file?
        @vmr_dll = pn
    else
        raise "DLL not found... exiting."
    end

    ffi_lib @vmr_dll
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
    attr_reader :layout, :strip_total, :bus_total

    BASIC = 1
    BANANA = 2
    POTATO = 3

    def layout=(value)
        @layout = value
    end

    def strip_total=(value)
        @strip_total = value.to_i
    end

    def bus_total=(value)
        @bus_total = value.to_i
    end

    def build_strips(type)
        self.layout =  {
            :strip => {:p_in => 0, :v_in => 0}, 
            :bus => {:p_out => 0, :v_out => 0},
            :in_vban => 0, 
            :out_vban => 0
        }

        if type == BASIC
            factory([2, 1, 2, 0, 4])
        elsif type == BANANA
            factory([3, 2, 3, 2, 8])
        elsif type == POTATO
            factory([5, 3, 5, 3, 8])
        end
    end

    def factory(values)
        num = 0

        @layout.each do |key, val|
            unless @layout[key] && @layout[key][val]
                val.each do |k, v|
                    @layout[key][k] = values[num]
                    num += 1
                end
            end
        end
        @layout[:in_vban] = values[num]
        @layout[:out_vban] = values[num]

        self.strip_total = 
        @layout[:strip][:p_in].to_i.+(@layout[:strip][:v_in].to_i)
        self.bus_total = 
        @layout[:bus][:p_out].to_i.+(@layout[:bus][:v_out].to_i)
    end

    def validate(name, num)
        num = num.to_i
        if name.eql? "strip"
            num < @strip_total
        elsif name.eql? "bus"
            num < @bus_total
        end
    end

    def shift(oldnum)
        num = oldnum.to_s.to_i - 1
        num.to_s
    end
end
