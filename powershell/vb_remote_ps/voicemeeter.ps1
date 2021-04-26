Function MacroButton_SetStatus {
    param(
        [int]$MODE
    )
    0..2 | ForEach-Object {
                                                         # ID,     SET          MODE
        [Int]$retval = $vmr::VBVMR_MacroButton_SetStatus([Int64]$_, [Single]1.0, [Int64]$MODE)
        if($retval -eq 0) { Write-Host("MB SETSTATUS SUCCESS") }
        Start-Sleep -s 1
        while($vmr::VBVMR_MacroButton_IsDirty() -eq 1) { Start-Sleep -s 0.01 }

                                                         # ID,     GET          MODE
        $ptr = [Single]0.0
        [Int]$retval = $vmr::VBVMR_MacroButton_GetStatus([Int64]$_, [ref]$ptr, [Int64]$MODE)
        if($retval -eq 0) { 
            Write-Host("MB GETSTATUS SUCCESS")
            Write-Host("MB ID:", $_, "STATE:", [Single]$ptr, "MODE:", $MODE)
        }

        Start-Sleep -s 0.2
                                                         # ID,     SET          MODE
        [Int]$retval = $vmr::VBVMR_MacroButton_SetStatus([Int64]$_, [Single]0.0, [Int64]$MODE)
        if($retval -eq 0) { Write-Host("MB SETSTATUS SUCCESS") }
        Start-Sleep -s 1
        while($vmr::VBVMR_MacroButton_IsDirty() -eq 1) { Start-Sleep -s 0.01 }

                                                         # ID,     GET          MODE
        $ptr = [Single]0.0
        [Int]$retval = $vmr::VBVMR_MacroButton_GetStatus([Int64]$_, [ref]$ptr, [Int64]$MODE)
        if($retval -eq 0) { 
            Write-Host("MB GETSTATUS SUCCESS")
            Write-Host("MB ID:", $_, "STATE:", [Single]$ptr, "MODE:", $MODE)
        }

        Start-Sleep -s 0.2
    }
}


Function Login {
    [Int]$retval = $vmr::VBVMR_Login()
    if($retval -eq 0) { Write-Host("LOGGED IN") }
    elseif($retval -eq 1) { 
        Write-Host("VB NOT RUNNING")

        [Int]$retval = $vmr::VBVMR_RunVoicemeeter([Int64]1)
        if($retval -eq 0) { Write-Host("STARTING VB") }
    } else { Exit }

    while($vmr::VBVMR_MacroButton_IsDirty() -eq 1) { Start-Sleep -s 0.01 }

    $ptr = 0
    [Int]$retval = $vmr::VBVMR_GetVoicemeeterType([ref]$ptr)
    if($retval -eq 0) { 
        if($ptr -eq 1) { Write-Host("VERSION:[BASIC]") }
        elseif($ptr -eq 2) { Write-Host("VERSION:[BANANA]") }
        elseif($ptr -eq 3) { Write-Host("VERSION:[POTATO]") }
        Start-Sleep -s 1
    }
}


Function Logout {
    [Int]$retval = $vmr::VBVMR_Logout()
    if($retval -eq 0) { Write-Host("LOGGED OUT") }
}


if ($MyInvocation.InvocationName -ne '.')
{
$Handles  = @'
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_Login();
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_Logout();
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_RunVoicemeeter(Int64 run);
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_GetVoicemeeterType(ref int ptr);

    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_MacroButton_IsDirty();
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_MacroButton_SetStatus(Int64 id, Single state, Int64 mode);
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_MacroButton_GetStatus(Int64 id, ref float ptr, Int64 mode);
'@

    $vmr = Add-Type -MemberDefinition $Handles -Name VMRemote -PassThru

    Login

    MacroButton_SetStatus -MODE 1
    MacroButton_SetStatus -MODE 2
    MacroButton_SetStatus -MODE 3

    Logout
}
