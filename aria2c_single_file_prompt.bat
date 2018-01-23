@ECHO OFF
REM If no argument is given, then prompt for one
IF [%1] == [] GOTO PROMPT

REM Set the variable to the first argument of the command line
set a=%1


:DOWNLOAD
REM If the variable is present, then start the download
echo.
echo File to Download: %1%
echo.
set currdir=%cd%
echo Current Folder: %currdir%
echo.
timethis aria2c.exe -s 5 --min-split-size=10MB -c --check-certificate=false -Z --file-allocation=none --max-connection-per-server=5 --truncate-console-readout=false --no-conf=true --dir=%currdir%  %a%

REM If done downloading, skip to Exit
GOTO EXIT

:PROMPT
REM Set %a% variable to blank
REM set a=
ECHO FILE: "%1"
ECHO.
SET /P 1= Type a URL and press ENTER: %=%
ECHO.
ECHO FILE: "%1"
IF "%1" =="" GOTO PROMPT

GOTO DOWNLOAD

:EXIT
pause
