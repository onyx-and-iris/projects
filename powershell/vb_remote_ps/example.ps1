try {
    . $PSScriptRoot\lib\voicemeeter.ps1

    $button[0].state = 1
    $button[0].state
    $button[0].state = 0
    $button[0].state

    $strip[0].mono = 1
    $strip[0].mono
    $strip[0].mono = 0
    $strip[0].mono

    $bus[2].mute = 1
    $bus[2].mute
    $bus[2].mute = 0
    $bus[2].mute
}
finally
{
    Logout
}
