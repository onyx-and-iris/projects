<#
.DESCRIPTION
   This short script calls ffmpeg to convert a recording made using gaming GPU into a constant frame rate editor
   friendly file for DaVinci Resolve.

   It takes a single argument that is the file name, error checks if no file is given and checks if the file was
   already run through the script.

.TODO
    Add file scanning for newly added files, if not converted then convert for batch conversion.
#>

IF ($args.count -eq 0) {
    Write-Host "Please give a file name to convert"
    Exit
}

$FILE_IN=$args[0] + ".mp4"
$FILE_OUT=$FILE_IN + "_constant60.mxf"

IF ([System.IO.File]::Exists($FILE_OUT)) {
    Write-Host "File was already converted... exiting script."
    Exit
}

Write-Host "Converting $FILE_IN to constant frame rate edit friendly file $FILE_OUT"

F:\zz_Programs\ffmpeg\bin\ffmpeg.exe -i $FILE_IN -c:v dnxhd -b:v 290M -c:a pcm_s16le -r 60 $FILE_OUT