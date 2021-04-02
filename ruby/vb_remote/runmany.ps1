param(
        [parameter(Mandatory=$false)]
        [Int] $num = 1,
        [parameter(Mandatory=$true)]
        [ValidateSet("basic","banana","potato")]
        [string]$t,
        [parameter(Mandatory=$false)]
        [switch]$p,[switch]$e
        )

$logfile = "test/${t}/"

if($p) { $_runtests = 'rake ${t}:pass'; $logfile = "test/${t}/${t}_pass.log" }
elseif($e) { $_runtests = 'rake ${t}:errors'; $logfile = "test/${t}/${t}_error.log" }

1..$num | ForEach-Object `
{ "Running test $_" | Tee-Object -FilePath $logfile -Append
Invoke-Expression $_runtests | Tee-Object -FilePath $logfile -Append }
