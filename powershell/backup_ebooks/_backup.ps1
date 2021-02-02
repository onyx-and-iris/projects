# Script to backup ebooks to usb drive. Script will prompt for destination drive letter
# Creates a comparison list to ensure only ebooks not previously backed up are copied.
# Error handling in case destination is empty will simply copy all available ebooks to
# flash pen. Script assumes it's in your ebooks directory otherwise set path of source.
# Script ignores any files in a folder named 'My Kindle Content' (duplicates).

# Feel free to use this script or modify it for your own purposes. I take no responsibility
# for use of this script and I don't make any promises that it will be suitable for any
# specific purpose. I find it useful for my own needs.

$usb_drive = Read-Host -Prompt 'Drive letter of usb flashpen?'

$source = "$PWD"
$destination = "${usb_drive}:\ebooks"

$logfile = "$PWD\_backup.log"

# check if logfile exists, if not create.
If (-Not [System.IO.File]::Exists($path)) {
	Out-File -FilePath $logfile
}

# full list of files in source and destination
$list_s = Get-ChildItem -Recurse -path $source
$list_d = Get-ChildItem -Recurse -path $destination

Write-Host $list_s
Write-Host $list_d

# difference list
Try {
	ForEach ($file in (Compare-Object -ReferenceObject $list_s -DifferenceObject $list_d -PassThru | `
	Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match ".pdf|.epub|.zip"})) {
			"Copying only files that don't exist in destination:" | Tee-Object -Append $logfile
			"$file to $destination" | Tee-Object -Append $logfile
			Copy-Item $source\$file $destination
		}
} Catch {
	Write-Host "Either source or destination are empty, failed to generate comparison list"
 
	"Copying ebooks to destination!" | Tee-Object -Append $logfile
	
	Get-ChildItem -Recurse -path $source | `
	Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match ".pdf|.epub|.zip"} | `
	Copy-Item -Destination $destination -Recurse -Force -verbose | Tee-Object -Append $logfile
}