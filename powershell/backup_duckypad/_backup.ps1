# Grab the system drive letter assigned to 'DUCKYPAD'
$DRV=$(((get-volume -FileSystemLabel DUCKYPAD | select Driveletter | `
select-string -Pattern "Driveletter") -split '=')[1])[0] + ":\"

# date+timestamp backups
$DIR_BACKUP="~/scripts/DuckyPad/" + $(get-date -f yyyy-MM-dd_HH:mm)

ssh vps "mkdir -p $DIR_BACKUP"; scp -rv $DRV/* vps:${DIR_BACKUP}
