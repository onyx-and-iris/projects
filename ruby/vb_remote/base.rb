require 'ffi'
require_relative 'inst.rb'

module VMR_API
    extend FFI::Library

    attr_reader :vmr_dll

    if ((os_bits = get_arch) == 64)
        dll_name = "VoicemeeterRemote64.dll"
    elsif os_bits == 32
        dll_name = "VoicemeeterRemote.dll"
    end

    pn = get_vbpath
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

    DELAY = 0.02
end

module Errors
    class LoginError < StandardError
        def message
            "Failed to login, success return value:"
        end
    end

    class APIError < StandardError
        def message
            "Callback Function Error, return value:"
        end
    end

    class BoundsError < StandardError
        def message
            "Value out of bounds"
        end
    end

    class VersionError < StandardError
        def message
            "Wrong Voicemeeter version"
        end
    end
end

module Strips
    include Errors

    attr_reader :layout, :strip_total, :bus_total, :vban_total

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

    def vban_total=(value)
        @layout[:in_vban] = value
        @layout[:out_vban] = value
        @vban_total = value
    end

    def composite_total=(value)
        if value < 0 || value > 7
            raise "Value out of bounds"
        end
        @composite_total = value
    end

    def insert_total=(value)
        if value < 0 || value > 33
            raise "Value out of bounds"
        end
        @insert_total = value
    end

    def build_strips(type)
        self.layout =  {
            :strip => {:p_in => 0, :v_in => 0}, 
            :bus => {:p_out => 0, :v_out => 0},
            :in_vban => 0, 
            :out_vban => 0,
            :patch_insert => 0
        }

        if type == BASIC
            factory([2, 1, 2, 0, 4, 0])
        elsif type == BANANA
            factory([3, 2, 3, 2, 8, 22])
        elsif type == POTATO
            factory([5, 3, 5, 3, 8, 33])
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
        self.vban_total = values[num]
        num += 1
        self.composite_total = 7
        self.insert_total = values[num]

        self.strip_total = 
        @layout[:strip][:p_in].to_i.+(@layout[:strip][:v_in].to_i)
        self.bus_total = 
        @layout[:bus][:p_out].to_i.+(@layout[:bus][:v_out].to_i)
    end

    def validate(name, num)
        """ 
        Validate boundaries unless param requires none 
        example: Reverb and Delay, then return true
        """
        if name == "strip"
            num < @strip_total
        elsif name == "bus"
            num < @bus_total
        elsif name == "instream" || name == "outstream"
            num < @vban_total
        elsif name == "composite" 
            num < @composite_total
        elsif name == "insert"
            if @type == POTATO
                num < @insert_total
            else
                raise VersionError
            end
        elsif name == "reverb" || name == "delay"
            if @type == POTATO
            else
                raise VersionError
            end
        end
    end
end

module Utils
    attr_reader :m1, :m2

    def m1=(value)
        @m1 = value.downcase
    end

    def m2=(value)
        @m2 = value.to_i
    end

    def test_regex(regex, param)
        regex.match(param) do |m|
            self.m1 = m[1]
            self.m2 = m[2]
        end
    end

    def shift(oldnum)
        oldnum - 1
    end
end
