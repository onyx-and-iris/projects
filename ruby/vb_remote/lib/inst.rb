require 'win32/registry'
require 'pathname'
require_relative 'errors'

include Errors

BASIC = 1
BANANA = 2
POTATO = 3

def get_arch
    key = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
    Win32::Registry::HKEY_LOCAL_MACHINE.open(key) do |reg|
        os_bits = reg["PROCESSOR_ARCHITECTURE"]
        if os_bits.include? 64.to_s
            return 64
        end
        return 32
    end
end

def get_vmpath(os_bits)
    vm_key = "VB:Voicemeeter {17359A74-1236-5467}"
    reg_key = "Software#{os_bits == 64 ? "\\WOW6432Node" : ""}\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\"

    Win32::Registry::HKEY_LOCAL_MACHINE.open(reg_key + vm_key) do |reg|           
        value = reg["UninstallString"]

        pn = Pathname.new(value)
        return pn.dirname
    end
    raise InstallErrors::DLLPathNotFoundError
end

def vmr_dll=(value)
    if value.file?
        @vmr_dll = value
    else
        raise InstallErrors::DLLNotFoundError
    end
end


if __FILE__ == $PROGRAM_NAME
    puts get_vmpath(64)
    puts get_arch
end
