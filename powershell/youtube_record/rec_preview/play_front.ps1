param([string]$capture,[string]$ffplay)

& $ffplay -f dshow -i video=$capture -vf scale=1024:-1