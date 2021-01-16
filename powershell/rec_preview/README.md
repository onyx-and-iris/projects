These scripts allow me to play directshow video stream and/or record to mkv format.
Looking around for current software that allowed me to record two cameras connected
to two capture cards was tougher than I thought. There were plenty of options
that seemed to cost a lot of money. This allows me to do it for free but without
any advanced functions like timecode. However, for us it works well enough, it keeps
the audio and video in sync for the duration of recording and we can start the
the recordings instantly at the same time (both video feeds and two channel audio).
Tested with DaVinci Resolve and everything was synced up and working great.

Feel free to use/modify these scripts to your needs. I take no responsibility for use
of them, use them at your own risk.

To use just run __record_and_preview.ps1. You'll need the correct permissions to run
powershell scripts on your user. You'll also need to modify the variables that point
to ffmpeg/ffplay as well as any absolute paths that point to the scripts that the
runner starts. If you aren't using Elgato capture cards you may need to change the
search pattern in the runner eg: -Pattern '(Game Capture.*Video). You should be able
to figure that out by looking at ffmpeg.txt that the script creates. Same with the
audio device. In fact, in the case that you want to record both video and audio from
an Elgato capture card you could simply change the search string for the audio to
-Pattern '(Game Capture.*Audio)'.

That's all for now, might update this if I add more to the scripts.