#Include, %A_ScriptDir%\VMR.ahk

voicemeeter := new VMR().login()

F1::voicemeeter.bus[1].gain++
F2::voicemeeter.bus[1].gain--

F3::voicemeeter.strip[1].gain++
F4::voicemeeter.strip[1].gain--
