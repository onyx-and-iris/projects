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
    $retval = $vmr::VBVMR_SetParameterFloat($PARAM, $VALUE)
    if($retval) { Throw "ERROR: CAPI return value: $retval" }
}


Function Param_Get {
    param(
        [String]$PARAM
    )
    Start-Sleep -m 50
    while(P_Dirty) { Start-Sleep -s 0.001 }

    $ptr = 0.0
    $retval = $vmr::VBVMR_GetParameterFloat($PARAM, [ref]$ptr)
    if($retval) { Throw "ERROR: CAPI return value: $retval" }
    $ptr
}


Function MB_Set {
    param(
        [Int64]$ID, [Single]$SET, [Int64]$MODE
    )
    $retval = $vmr::VBVMR_MacroButton_SetStatus($ID, $SET, $MODE)
    if($retval) { Throw "ERROR: CAPI return value: $retval" }
}


Function MB_Get {
    param(
        [Int64]$ID, [Int64]$MODE
    )
    Start-Sleep -m 50
    while(M_Dirty) { Start-Sleep -s 0.001 }

    $ptr = 0.0
    $retval = $vmr::VBVMR_MacroButton_GetStatus($ID, [ref]$ptr, $MODE)
    if($retval) { Throw "ERROR: CAPI return value: $retval" }
    $ptr
}


Function Login {
    $retval = $vmr::VBVMR_Login()
    if(-not $retval) { Write-Host("LOGGED IN") }
    elseif($retval -eq 1) { 
        Write-Host("VB NOT RUNNING")

        $retval = $vmr::VBVMR_RunVoicemeeter([Int64]1)
        if(-not $retval) { Write-Host("STARTING VB") }
    } else { Exit }

    while(P_Dirty -or M_Dirty) { Start-Sleep -s 0.001 }

    $ptr = 0
    $retval = $vmr::VBVMR_GetVoicemeeterType([ref]$ptr)
    if(-not $retval) { 
        if($ptr -eq 1) { Write-Host("VERSION:[BASIC]") }
        elseif($ptr -eq 2) { Write-Host("VERSION:[BANANA]") }
        elseif($ptr -eq 3) { Write-Host("VERSION:[POTATO]") }
        Start-Sleep -s 1
    }
}


Function Logout {
    $retval = $vmr::VBVMR_Logout()
    if(-not $retval) { Write-Host("LOGGED OUT") }
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
            MB_Set -ID $_ -SET 1.0 -MODE $mode
            $res = MB_Get -ID $_ -MODE $mode
            Write-Host("id: $_ mode: $mode = $res")

            MB_Set -ID $_ -SET 0.0 -MODE $mode
            $res = MB_Get -ID $_ -MODE $mode
            Write-Host("id: $_ mode: $mode = $res")
        }
    }

    0..2 | ForEach-Object {
        $num = $_
        @("Mute", "Mono", "Solo", "A1", "B1") | % {
            Param_Set -PARAM "Strip[$num].$_" -VALUE 1.0
            $res = Param_Get -PARAM "Strip[$num].$_"
            Write-Host("Strip[$num].$_ =", $res)

            Param_Set -PARAM "Strip[$num].$_" -VALUE 0.0
            $res = Param_Get -PARAM "Strip[$num].$_"
            Write-Host("Strip[$num].$_ =", $res)
        }
    }

    Logout
}
