@ECHO OFF
REM This script will check the uptime of a specified computer.

:START
CLS
@ECHO Check Uptime of a Remote Computer
REM Reset the variable to blank
set COMPUTERNAME=
REM Prompt for computer name
ECHO.
SET /P COMPUTERNAME= Type the computer name, then press ENTER: %=%
REM Check for a missing variable in the command line
if "%COMPUTERNAME%"=="" GOTO HELP

REM Check if the command exists on the computer
if NOT exist C:\windows\uptime.exe GOTO ALTERNATE
ECHO.
REM Execute the uptime command with the name of the computer
cmd.exe /c C:\windows\uptime.exe \\%COMPUTERNAME%
ECHO.

REM Loop through lookup again
GOTO RESTART

:HELP
CLS
REM Display help if no variable is specified when prompted
ECHO.
ECHO *** You forgot to enter the computer name!
ECHO *** Please enter the computer name when prompted.
ECHO *** For Example: CAD1100134
ECHO.
REM Then take user back to the prompt
GOTO START

:ALTERNATE
REM If uptime.exe command not found, check for the systeminfo.exe command
CLS
ECHO.
ECHO *** UPTIME.exe command not found!
ECHO *** Trying to use SYSTEMINFO.exe ...
ECHO *** Please wait while the query executes
ECHO.
REM Check to see if the systeminfo.exe is present on the system
if NOT exist C:\Windows\System32\systeminfo.exe  GOTO MISSING
ECHO.
cmd.exe /c  C:\Windows\System32\systeminfo.exe /S %COMPUTERNAME% | find /I "System Boot Time:"
ECHO.
GOTO RESTART

:MISSING
REM If the uptime.exe or systeminfo.exe commands does not exist, show helpful info
CLS
ECHO.
echo *** No UPTIME or SYSTEMINFO commands found. Please download UPTIME from here: 
echo *** http://support.microsoft.com/kb/232243
echo *** and place in your Windows folder
ECHO.
pause
ECHO.
GOTO END


:RESTART
REM Allows you to run the command again to look up another system
ECHO.
ECHO Select (Y)es or (N)o or just press ENTER to exit
ECHO.
SET INPUT=
SET /P INPUT=Would you like to go again? (y/N) 
ECHO.

if "%INPUT%"=="" GOTO END
IF /I '%INPUT%'=='y' GOTO START
IF /I '%INPUT%'=='N' GOTO END

CLS

:END
REM Nothing else to do - just exit.

