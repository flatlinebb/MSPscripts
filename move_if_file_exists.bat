@ECHO OFF
REM REM Check if TXT files are pressent
IF EXIST %base_dir%\*.TXT GOTO PRESENT
ECHO No Files to move - exiting. >> %clean_log% 2>&1
echo. >> %clean_log%
GOTO END

:PRESENT
REM REM List all existing TXT files in the working folder
dir %base_dir%\*.txt >> %clean_log% 2>&1
echo. >> %clean_log%

REM REM Move all existing TXT files to the archive folder
echo. >> %clean_log%
echo Moving old files to archive: >> %clean_log% 2>&1
echo. >> %clean_log%
move %base_dir%\*.txt %archive% >> %clean_log% 2>&1
echo. >> %clean_log%
echo Done moving files :) >> %clean_log%
echo. >> %clean_log%
GOTO END

:END
REM REM Create an Event in Windows Event Log Application section
REM REM Make sure ther EVENTCREATE.EXE program is available on the server where the script will be executed!
eventcreate /l application  /so %carrier%SAC_daily_cleanup.bat /t information /id 200 /d "Old %carrier%SAC files have been archived. Please see %clean_log% for more details." >>  %clean_log% 2>&1
echo. >> %clean_log%
