<#
	Runner for convert and play scripts. This will run the other scripts as background jobs
	alowing all four to run simultaneously. Unlike linux it doesn't provide an interactive
	shell so can only be used to record filetypes that can be record interrupted (ie not mp4).

	This script also runs the mic recordings. Can be used with devices that supprot DirectShow.
#>

Write-Host "Starting runner... preview and record"
Start-Job -Name one_play -ScriptBlock { E:\ffmpeg\one_play.ps1 }
Start-Job -Name two_play -ScriptBlock { E:\ffmpeg\two_play.ps1 }
Start-Job -Name one_convert -ScriptBlock { E:\ffmpeg\one_convert.ps1 }
Start-Job -Name two_convert -ScriptBlock { E:\ffmpeg\two_convert.ps1 }
Start-Job -Name mics_rec -ScriptBlock { E:\ffmpeg\mics_rec.ps1 }
