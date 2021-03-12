require 'win32/registry'
require 'Pathname'

def get_arch
    key = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
    Win32::Registry::HKEY_LOCAL_MACHINE.open(key) do |reg|
        os_size = reg["PROCESSOR_ARCHITECTURE"]
        if os_size.eql? "AMD64"
            return 64
        end
        return nil
    end
end

def get_vbpath
    vb_dn = 'Voicemeeter, The Virtual Mixing Console'
    keys = [
        'Software\Microsoft\Windows\CurrentVersion\Uninstall',
        'Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    ]
    
    keys.each do |key|
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
    return nil
end


if __FILE__ == $PROGRAM_NAME
    #puts get_vbpath
    get_arch
end