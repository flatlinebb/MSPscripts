@ECHO OFF
reg query "HKLM\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" /v Version > checkdotnet.txt
REM type checkdotnet.txt
find /i "4." < checkdotnet.txt > StringCheck.txt
REM type StringCheck.txt
for /f "tokens=3" %%x in (StringCheck.txt) do set Ver=%%x
REM ECHO %Ver%
if %Ver% GEQ 4.5.2 goto PRESENT

:NOTPRESENT
ECHO DotNET version %Ver% is installed, upgrade needed ...
ECHO .

ECHO Installing DotNET v.4.5.2 now ...
"\\mbi-dc1\Software\Oracle\NDP452-KB2901907-x86-x64-AllOS-ENU.exe" /q /norestart /log c:\kworking\NDP452-KB2901907-x86-x64-AllOS-ENU_log.txt

del /q checkdotnet.txt
del /q StringCheck.txt

GOTO END

:PRESENT
ECHO DotNET %Ver% present, skipping install.
GOTO END

:END
ECHO Exiting!
EXIT