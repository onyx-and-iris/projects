. $PSScriptRoot\base.ps1

class Strip {
    [int32]$id

    # Constructor
    Strip ([Int]$id)
    {
        $this.id = $id
    }

    [void] Setter($cmd, $set) {
        Param_Set -PARAM $cmd -VALUE $set
    }

    [int] Getter($cmd) {
        return Param_Get -PARAM $cmd
    }

    [string] cmd ($arg) {
        return "Strip[" + $this.id + "].$arg"
    }

    hidden $_mono = $($this | Add-Member ScriptProperty 'mono' `
        {
            # get
            $this.Getter($this.cmd('Mono'))
        }`
        {
            # set
            param ( $arg )
            $this._mono = $this.Setter($this.cmd('Mono'), $arg)
        }
    )

    hidden $_solo = $($this | Add-Member ScriptProperty 'solo' `
        {
            # get
            $this.Getter($this.cmd('Solo'))
        }`
        {
            # set
            param ( $arg )
            $this._solo = $this.Setter($this.cmd('Solo'), $arg)
        }
    )

    hidden $_mute = $($this | Add-Member ScriptProperty 'mute' `
        {
            # get
            $this.Getter($this.cmd('Mute'))
        }`
        {
            # set
            param ( $arg )
            $this._mute = $this.Setter($this.cmd('Mute'), $arg)
        }
    )
}

Function Strips {
    [System.Collections.ArrayList]$strip = @()
    0..69 | ForEach-Object {
        [void]$strip.Add([Strip]::new($_))
    }
    $strip
}

if ($MyInvocation.InvocationName -ne '.')
{

    Login

    $strip = Strips

    $strip[0].mono = 1
    $strip[0].mono
    $strip[0].mono = 0
    $strip[0].mono

    Logout
}
