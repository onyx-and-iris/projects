param(
        [parameter(Mandatory=$false)]
        [Int] $num = 1,
        [switch]$p,[switch]$e,[switch]$o
        )

if($p) { $_runtests = 'rake pass' }
elseif($e) { $_runtests = 'rake errors' }
elseif($o) { $_runtests = 'rake other' }

1..$num | % { Write-Host "Running test $_"; Invoke-Expression $_runtests }
