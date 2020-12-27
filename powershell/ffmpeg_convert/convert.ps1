<#
    This script calls ffmpeg and converts an mp4 recorded by GPU  
    to dnxhd constant frame rate 60 editor friendly file ready for 
    DaVinci Resolve or other editor.
    
    First, edit the line in the code that points to your ffmpeg exe.
    Then navigate to your recordings folder in Windows Explorer, in 
    the explorer search bar type powershell.exe to open powershell in 
    current directory.

    Then you can run the script using ./_c260 nameofrecording. This will 
    create a file of the same name with mxf extension. You may need to
    alter your execution policy in order to run the script, I suggest
    modifying scope process to bypass for simply running the script
    occasionally. When giving file name to script in powershell don't
    include extension .mp4.

    I take no responsibility for use of this script. It's useful for me
    but feel free to use it for your own purposes.
          
#>

IF ($args.count -eq 0) {
    Write-Host "Please give a file name to convert"
    Exit
}


$FILENAME = $args[0]
$FILE_IN = $FILENAME + ".mp4"
$FILE_OUT = $FILENAME + "_constant60.mxf"
# CHANGE THIS TO POINT TO YOUR FFMEG EXE
$DIREXE = "PATH\TO\ffmpeg.exe"

IF (![System.IO.File]::Exists($FILE_IN)) {
    Write-Host "Error... that file does not exist... exiting script"
    Exit
}

IF ([System.IO.File]::Exists($FILE_OUT)) {
    Write-Host "File was already converted... exiting script."
    Exit
}

Write-Host "Converting $FILE_IN to cfr 60 edit friendly file $FILE_OUT"

& $DIREXE -i $FILE_IN -c:v dnxhd -b:v 290M -c:a pcm_s16le -r 60 $FILE_OUT