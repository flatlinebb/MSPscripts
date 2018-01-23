REM ---------------------------------------------------------------------------------------
REM Automation script for copying Windows Profile files following a Windows Profile Rebuild
REM It will copy files and directories from the old/corrupt profile to new folder
REM ---------------------------------------------------------------------------------------
REM ----------------------written by Bart Boryczko-----------------------------------------
REM ------------------for Delta Enterprise Support Center----------------------------------
REM ---------------------------------------------------------------------------------------
:START
REM REM Rebuilding the profile 
REM REM Prompt for remote computer name - store as variable %COMPUTERNAME% (ex. CAD1100172)
REM Reset the variable to blank
set COMPUTERNAME=
REM Prompt for computer name
ECHO.
SET /P COMPUTERNAME= Type the computer name, then press ENTER: %=%
REM Check for a missing variable in the command line
REM if "%COMPUTERNAME%"=="" GOTO CNHELP
if "%COMPUTERNAME%"=="" (echo "Value not entered")
REM Prompt for LAN ID - store as variable %LANID% (ex. CA55260)
REM Reset the variable to blank
set LANID=
REM Prompt for LAN ID name
ECHO.
SET /P LANID= Type the LAN ID name, then press ENTER: %=%
REM Check for a missing variable in the command line
REM if "%LANID%"=="" GOTO LANHELP
if "%LANID%"=="" (echo "Value not entered")

REM Combine the variables to create an new variable %OLDPROF% = \\%COMPUTERNAME%\C$\DOCUMENTS AND SETTINGS\%LANID%\
REM Check is folder exists - if not, error, then prompt again
if NOT exist "\\%COMPUTERNAME%\C$\DOCUMENTS AND SETTINGS\%LANID%\" GOTO PROMPT

:EXISTS
REM If original folder exists, prompt for new profile folder name

:PROMPT
REM Prompt for original profile name - store as var %MANUALPROF%
SET /P MANUALPROF= Type the Windows Profile folder name if not same as LAN ID, then press ENTER: %=%

REM If original folder exists, prompt for new profile folder name
REM Check if already exists - if not, proceed
REM Create new profile folder - store as var $NEWPROF
REM i. Rename user's OLD profile to profile name.mmdd (example CA28344.0708)
ren 
REM REM i. Open another connection to the system c$ from run command and navigate to the new profile
REM Copy the following folders from original profile to new profile:
REM Copy desktop content
REM "C:\Documents and Settings\$OLDPROF\Desktop" --> "C:\Documents and Settings\$NEWPROF\Desktop"
REM Copy Favorites
REM C:\Documents and Settings\$OLDPROF\Favorites --> "C:\Documents and Settings\$NEWPROF\Favorites"
REM Copy My Documents
REM "C:\Documents and Settings\$OLDPROF\My Documents" --> "C:\Documents and Settings\$NEWPROF\My Documents"
REM REM iii. Copy Outlook profile folders “Signatures” and “Outlook” from OLD profile c$\Documents and Settings\caXXXX\Application Data\Microsoft
REM Copy Outlook profile
REM "C:\Documents and Settings\$OLDPROF\Application Data\Microsoft\Outlook" --> "C:\Documents and Settings\$NEWPROF\Application Data\Microsoft\Outlook"
REM Copy Outlook Address Book
REM "C:\Documents and Settings\$OLDPROF\Application Data\Microsoft\Address Book" --> "C:\Documents and Settings\$NEWPROF\Application Data\Microsoft\Address Book"
REM Copy Outlook Signatures
REM "C:\Documents and Settings\$OLDPROF\Application Data\Microsoft\Signatures" --> "C:\Documents and Settings\$NEWPROF\Application Data\Microsoft\Signatures"
REM REM iv. Paste those folders into NEW profile c$\Documents and Settings\caXXXX\Application Data\Microsoft
REM REM v. Configure outlook, verify functionality and check if nickname cache was imported 

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


REM :CNHELP
REM ECHO.
REM ECHO Computer Name "%COMPUTERNAME%" Does not exist or cannot be reached (offline).
REM ECHO Please verify Name and/or Connectivity and re-enter the Computer Name
REM ECHO.
REM GOTO START

REM :LANHELP
REM ECHO.
REM ECHO The LAN ID "%LANID%" Does not exist.
REM ECHO Please verify Name and/or Connectivity and re-enter the Computer Name
REM ECHO.
REM GOTO START

:END
REM Nothing left to do, just exit.
