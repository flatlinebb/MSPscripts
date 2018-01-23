@echo off

net time \\edfdc /set /y

net use H: /home /y

net use p: \\edfdc\public /y

net use o: \\edfdc\support

xcopy /y "\\edfdc\public\software\webmail.url" "%UserProfile%\Desktop\"


REM REM If the computer you are logging onto is called "EDHF-TELESTAFF"
REM REM then skip the Printer mapping vbs script
IF /i %COMPUTERNAME% == EDHF-TELESTAFF GOTO SKIP

REM REM For all other computers, execute the script
IF /i NOT %COMPUTERNAME% == EDHF-TELESTAFF GOTO OTHERS

:OTHERS
echo "Mapping Network Printers"
\\edfdc\netlogon\Printers.vbs

rem \\edfdc\ofcscan\autopcc.exe

GOTO :EOF

:SKIP
echo "Skipping Printers.vbs"

:EOF
echo "Logon script complete"