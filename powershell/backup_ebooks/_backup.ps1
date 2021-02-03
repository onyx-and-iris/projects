<#
	This script allows me to backup ebooks to usb and remote server via -vps flag.
	Both routines check for empty lists passed to comparator object.
	Will only backup files not previously backed up.
	Ignores any files in a folder names My Kindle Content as well as extensions not
	matching the specified exclusions regex
	Script will prompt for usb drive letter if -vps parameter not passed.
 
	Feel free to use or modify this script for your own purposes. Use at your own risk,
	I take no responsibility for its use and make no promises that it will be fit for
	any particular purpose, I find it useful for my own purposes.
#>
param([switch]$vps)

$source = "$PWD"
$exclusions = ".pdf|.epub|.zip"

$logfile = "$PWD\_backup.log"

# check if logfile exists, if not create.
If (-Not [System.IO.File]::Exists($path)) {
	Out-File -FilePath $logfile
}


if($vps) {
	$destination = "~/scp/ebooks2"
	$_getremotelist = "ssh vps 'ls -A1 ${destination}'"	
	
	# full list of files in source and destination
	$list_s = Get-ChildItem -Recurse -path $source
	$list_d = Invoke-Expression $_getremotelist
	
	Try {
		ForEach ($file in (Compare-Object -ReferenceObject $list_s -DifferenceObject $list_d -PassThru | `
		Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match $exclusions})) {
				"Copying only files that don't exist in destination:" | Tee-Object -Append $logfile
				"$file to $destination" | Tee-Object -Append $logfile
				scp -vp $source\$file vps:$destination
			}
	} Catch {
		Write-Host "Either source or destination are empty, failed to generate comparison list"
	 
		"Copying ebooks to destination!" | Tee-Object -Append $logfile
		
		ForEach ($file in (Get-ChildItem -Recurse -path $source | `
		Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match $exclusions})) {
			"Copying only files that don't exist in destination:" | Tee-Object -Append $logfile
			"$file to $destination" | Tee-Object -Append $logfile
			scp -vp $source\$file vps:$destination
		}			
	}
			
} else {
	$usb_drive = Read-Host -Prompt 'Drive letter of usb flashpen?'
	$destination = "${usb_drive}:\ebooks"	
	
	# full list of files in source and destination
	$list_s = Get-ChildItem -Recurse -path $source
	$list_d = Get-ChildItem -Recurse -path $destination
	
	# create difference list and copy based on simple regex
	Try {
		ForEach ($file in (Compare-Object -ReferenceObject $list_s -DifferenceObject $list_d -PassThru | `
		Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match $exclusions})) {
				"Copying only files that don't exist in destination:" | Tee-Object -Append $logfile
				"$file to $destination" | Tee-Object -Append $logfile
				Copy-Item $source\$file $destination
			}
	} Catch {
		Write-Host "Either source or destination are empty, failed to generate comparison list"
	 
		"Copying ebooks to destination!" | Tee-Object -Append $logfile
		
		Get-ChildItem -Recurse -path $source | `
		Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match $exclusions} | `
		Copy-Item -Destination $destination -Recurse -Force -verbose | Tee-Object -Append $logfile
	}		
}
