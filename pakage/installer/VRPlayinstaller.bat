@ECHO OFF
SETLOCAL

SET CompilerExe=
FOR /F "eol=; tokens=1,2* delims=	" %%a IN ('REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Inno Setup 5_is1" /v InstallLocation') DO (
	SET CompilerExe=%%c
)
SET CompilerExe=%CompilerExe%ISCC.exe
ECHO Using compiler executable '%CompilerExe%'.

"%CompilerExe%" "%cd%\VRPlayinstaller.iss"
IF %ERRORLEVEL% NEQ 0 GOTO :EndErr

GOTO :End
:EndErr
ECHO Press any key to exit.
PAUSE>NUL

:End
ENDLOCAL