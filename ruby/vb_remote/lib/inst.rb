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

def get_vbpath
    vb_dn = 'Voicemeeter, The Virtual Mixing Console'
    [
        'Software\Microsoft\Windows\CurrentVersion\Uninstall',
        'Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    ].each do |key|
        Win32::Registry::HKEY_LOCAL_MACHINE.open(key) do |reg|
            reg.each_key do |key|             
                k = reg.open(key)

                displayname     = k["DisplayName"] rescue nil    
                uninstallpath   = k["UninstallString"] rescue nil

                if(displayname && (displayname.eql? vb_dn))
                    pn = Pathname.new(uninstallpath)
                    return pn.dirname
                end
            end
        end
    end
    raise DLLNotFoundError
end

def inst_exe=(value)
    if value == BASIC
        exe = "voicemeeter.exe"
    elsif value == BANANA
        exe = "voicemeeterpro.exe"
    elsif value == POTATO
        if @os_bits == 64
            exe = "voicemeeter8x64.exe"
        else
            exe = "voicemeeter8.exe"
        end
    end
    if get_vbpath.join(exe).executable?
        @inst_exe = String(get_vbpath.join(exe))
    else
        raise EXENotFoundError
    end
end

def vmr_dll=(value)
    if value.file?
        @vmr_dll = value
    else
        raise DLLNotFoundError
    end
end


if __FILE__ == $PROGRAM_NAME
    puts get_vbpath
    puts get_arch
end
