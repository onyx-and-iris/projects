# This script monitors the folder we save all of our recordings to
# and deletes mp4 and mkv files older than two weeks.
# excludes and logs altered (according to code) with parameters
param([switch]$cleanup,[switch]$dualstreams,[switch]$reviews)

$path_rec = "PATH\TO\RECORDINGS"
$backlog = (Get-Date).AddDays(-14)
$filetypes = ('*.mp4', '*.mkv')  

$logfile = "PATH\TO\logfile.log"


# set excludes and modify log based on parameters
if ( $PSBoundParameters.Values.Count -eq 0 ) {
  # log cronjob and execute cleanup
  "[$(Get-Date)] Running CRONJOB:" | Add-Content $logfile
  
  $excludes = "_saved"
  $write_tolog = 'Add-Content -Path $logfile -Value "No recordings older than 14 days"'
}
  elseif ( $cleanup ) {
  $excludes = "_saved"
  $write_tolog = 'Add-Content -Path $logfile -Value "No recordings older than 14 days"'
} elseif ( $dualstreams ) {
  $excludes = "_saved|reviews"
  $write_tolog = 'Add-Content -Path $logfile -Value "No dualstreams older than 14 days"'
} elseif ( $reviews ) {
  $excludes = "_saved|dualstreams"
  $write_tolog = 'Add-Content -Path $logfile -Value "No reviews older than 14 days"'
}

# bash-like logical OR does not work with invoke-expression, will always return 0
# since the expression was invoked succesfully whether the command failed or not.
# Invoke-Expression $cleanup; if (-not $?) { Invoke-Expression $write_tolog }

$count = 0
ForEach ($file in $(Get-ChildItem -Recurse $path_rec -Include $filetypes -File | Where-Object {$_.PSParentPath -notmatch $excludes -and $_.CreationTime -lt $backlog})) {
  $count += $file.count
  Remove-Item $file -Verbose | Add-Content $logfile
}; if (-not $count) { Invoke-Expression $write_tolog } else {
  
  "$count files cleared from backlog" | Add-Content $logfile
}


exit