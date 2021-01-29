$d = Read-Host -Prompt 'Drive letter of usb flashpen?'

$source = "PATH\TO\ebooks"
$destination = "${d}:\ebooks"

# full list of files in source and destination
$list_s = Get-ChildItem -Recurse -path $source
$list_d = Get-ChildItem -Recurse -path $destination

# difference list
Write-Host "Copying only files that don't exist in destination:"

ForEach ($file in (Compare-Object -ReferenceObject $list_s -DifferenceObject $list_d -PassThru | `
Where-Object { $_.PSParentPath -notlike "*My Kindle Content" -and $_.Extension -match ".pdf|.epub|.zip"})) {
        Write-Host "$file to $destination"
        Copy-Item $source\$file $destination
    }