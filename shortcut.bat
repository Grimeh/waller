@echo off

set TARGET='%~dp0\run.bat'
set SHORTCUT='C:\%HOMEPATH%\Desktop\Waller.lnk'
set ICON='%~dp0\waller.ico'
set PWS=powershell.exe -ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile

%PWS% -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut(%SHORTCUT%); $S.TargetPath = %TARGET%; $S.IconLocation = %ICON%; $S.Save()"
