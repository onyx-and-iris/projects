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

    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_IsParametersDirty();
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_SetParameterFloat(String param, Single value);
    [DllImport(@"C:\Program Files (x86)\VB\Voicemeeter\VoicemeeterRemote64.dll")]
    public static extern int VBVMR_GetParameterFloat(String param, ref float ptr);
'@

$vmr = Add-Type -MemberDefinition $Handles -Name VMRemote -PassThru

Function Param_Set {
    param(
        [String]$PARAM, [Single]$VALUE
    )
    [Int]$retval = $vmr::VBVMR_SetParameterFloat([String]$PARAM, [Single]$VALUE)
    if($retval -ne 0) { Write-Host("ERROR: CAPI return value: $retval") }
}

Function Param_Get {
    param(
        [String]$PARAM
    )
    Start-Sleep -m 50
    while(P_Dirty -eq 1) { Start-Sleep -s 0.001 }

    $ptr = [Single]0.0
    [Int]$retval = $vmr::VBVMR_GetParameterFloat([String]$PARAM, [ref]$ptr)
    if($retval -ne 0) { Write-Host("ERROR: CAPI return value: $retval") }
}

Function MB_Set {
    param(
        [Int64]$ID, [Single]$STATE, [Int64]$MODE
    )
                                                     # ID,      SET          MODE
    [Int]$retval = $vmr::VBVMR_MacroButton_SetStatus([Int64]$ID, [Single]$STATE, [Int64]$MODE)
    if($retval -ne 0) { Write-Host("ERROR: CAPI return value: $retval") }
}

Function MB_Get {
    param(
        [Int64]$ID, [Int64]$MODE
    )
    Start-Sleep -m 50
    while(M_Dirty -eq 1) { Start-Sleep -s 0.001 }

                                                     # ID,      GET         MODE
    $ptr = [Single]0.0
    [Int]$retval = $vmr::VBVMR_MacroButton_GetStatus([Int64]$ID, [ref]$ptr, [Int64]$MODE)
    if($retval -ne 0) { Write-Host("ERROR: CAPI return value: $retval") }
    $ptr
}


Function Login {
    [Int]$retval = $vmr::VBVMR_Login()
    if($retval -eq 0) { Write-Host("LOGGED IN") }
    elseif($retval -eq 1) { 
        Write-Host("VB NOT RUNNING")

        [Int]$retval = $vmr::VBVMR_RunVoicemeeter([Int64]1)
        if($retval -eq 0) { Write-Host("STARTING VB") }
    } else { Exit }

    while(P_Dirty -eq 1 -or M_Dirty -eq 1) { Start-Sleep -s 0.001 }

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

Function P_Dirty {
    $vmr::VBVMR_IsParametersDirty()
}

Function M_Dirty {
    $vmr::VBVMR_MacroButton_IsDirty()
}


if ($MyInvocation.InvocationName -ne '.')
{
    Login

    1..3 | ForEach-Object {
        $mode = $_
        0..2 | ForEach-Object {
            $num = $_
            MB_Set -ID $num -STATE 1.0 -MODE $mode
            $res = MB_Get -ID $num -MODE $mode
            Write-Host("id: $num mode: $mode = $res")

            MB_Set -ID $num -STATE 0.0 -MODE $mode
            $res = MB_Get -ID $num -MODE $mode
            Write-Host("id: $num mode: $mode = $res")
        }
    }

    0..2 | ForEach-Object {
        $num = $_
        @("Mute", "Mono", "Solo", "A1", "B1") | % {
            Param_Set -PARAM "Strip[$num].$_" -VALUE 1.0
            Param_Get -PARAM "Strip[$num].$_"
            Param_Set -PARAM "Strip[$num].$_" -VALUE 0.0
            Param_Get -PARAM "Strip[$num].$_"
        }
    }

    Logout
}
