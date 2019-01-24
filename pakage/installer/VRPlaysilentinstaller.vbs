Set oShell = CreateObject ("Wscript.Shell")
Dim strArgs
strArgs = "cmd /C VRPlayinstaller.bat"
oShell.Run strArgs, 0, false