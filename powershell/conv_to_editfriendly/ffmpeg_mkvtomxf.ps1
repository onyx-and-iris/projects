<#
	DESCRIPTION.
	    This script calls ffmpeg and converts an mkv recorded by GPU  
	    to dnxhd constant frame rate 60 editor friendly file ready for 
	    DaVinci Resolve or other editor.
   
	USE. 
	    First, edit the line in the code that points to your ffmpeg exe.
	    Then navigate to your recordings folder in Windows Explorer, in 
	    the explorer search bar type powershell.exe to open powershell in 
	    current directory.
	    Then you can run the script using ./_c260 nameofrecording. This will 
	    create a file of the same name with mxf extension. You may need to
	    alter your execution policy in order to run the script, I suggest
	    modifying scope process to bypass for simply running the script
	    occasionally. 
    
	DISCLAIMER.
	    I take no responsibility for use of this script. It's useful for me
            but feel free to use it for your own purposes.
          
#>

IF ($args.count -eq 0) {
    Write-Host "Please give a file name to convert"
    Exit
}


$FILENAME = $args[0]
# CHANGE THIS TO POINT TO YOUR FFMEG EXE
$DIREXE = "PATH\TO\ffmpeg.exe"

IF (! $("$FILENAME" -Like "*.mkv")) {
    $FILE_IN = $FILENAME + ".mkv"
    Write-Host "DEBUG: Adding file extension... $FILE_IN"
    $FILE_OUT = $FILENAME + ".mxf"
} ELSE {
    $FILE_IN = $FILENAME
    $FILE_OUT = $FILENAME.Substring(0,$FILENAME.Length-4) + ".mxf"
    Write-Host "DEBUG: Value of FILE_IN: $FILE_IN"
    Write-Host "DEBUG: Value of FILE_OUT: $FILE_OUT"
}


IF (![System.IO.File]::Exists($FILE_IN)) {
    Write-Host "Error... $FILE_IN does not exist... exiting script"
    Exit
}

IF ([System.IO.File]::Exists($FILE_OUT)) {
    Write-Host "File was already converted... exiting script."
    Exit
}

Write-Host "Converting $FILE_IN to cfr 60 edit friendly file $FILE_OUT"

& $DIREXE -i $FILE_IN -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p -c:a pcm_s16le -r 60 $FILE_OUT
