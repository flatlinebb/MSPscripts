@ECHO OFF
REM -------------------------------------------------------------------
REM ---------- Remote MS Communicator 2005 Install script -------------
REM -------------------------------------------------------------------
REM -------------- Written by Bart Boryczko on 10/6/11 ----------------
REM ----------------- For ENTERPRISE SUPPORT CENTER -------------------
REM This script will execute the MS Comm 2005 install from a network drive.
REM It runs silently, with no feedback on the customer's screen.
REM It will check for presence of PSEXEC tool on the local PC.
REM And if not found, it will suggest where to download the tool from.
REM SCript will also verify that MS Comm 2005 is not already installed.
REM And also check that the target machine is a WinXP PC.

REM First, make sure that PSEXEC is installed and available
REM IF NOT EXIST psexec.exe GOTO PSEXEC

:START
REM Reset the variable to blank, so the script does not get confused
SET COMPUTERNAME=
REM Reset the location variable to blank as well
SET LOCATION=
REM Prompt for computer name
ECHO.
REM Get the computer name first and store it as a variable
SET /P COMPUTERNAME= Type the computer name, then press ENTER: %=%
REM Check for a missing variable in the command line
if "%COMPUTERNAME%"=="" GOTO HELP
REM Confirm entry
ECHO You have entered the following computer name: "%COMPUTERNAME%"
REM PAUSE

REM Verify the remote PC is Windows XP
ECHO.
REM Lookup Operating System remotely
systeminfo -s %COMPUTERNAME% | find /I "OS Name:"
ECHO.
:REPEAT
REM Ask to confirm
ECHO Select (Y)es or (N)o below 
ECHO.
SET OSNAME=
SET /P OSNAME=Is the Operating System listed above Windows XP? (y/N) 
ECHO.

if "%OSNAME%"=="" GOTO REPEAT
REM If WinXP, then go on to the next step
IF /I '%OSNAME%'=='y' GOTO CHECK
REM If not WinXP, go back to START
IF /I '%OSNAME%'=='N' GOTO START

:CHECK
REM Then, check if Comm is already installed
psexec \\%COMPUTERNAME% cmd /c dir "C:\Documents and Settings\All Users\Start Menu\Programs" /b | find /I "Communicator"
:REPEAT2
ECHO Select (Y)es or (N)o below 
ECHO.
SET COMM=
SET /P COMM=Is the MS Communicator 2005 listed above? (y/N) 
ECHO.

if "%COMM%"=="" GOTO REPEAT2
REM If Comm not installed, then go on to the next step
IF /I '%COMM%'=='y' GOTO INSTALLED
REM If Comm not installed, then go on to the next step
IF /I '%COMM%'=='N' GOTO INSTALL


:INSTALL
REM Next, run the install on the remote machine
REM Check if "install_comm.bat" exists
IF NOT EXIST install_comm.bat GOTO BATCH
psexec \\%COMPUTERNAME% -u deltads\ca55260 -c install_comm.bat
ECHO.
ECHO If exit code above is "0" then installation was most likely successful!
ECHO.

REM Finally, confirm that Comm appears in the Start Menu
ECHO Verifying that MS Comm is installed.
psexec \\%COMPUTERNAME% cmd /c dir "C:\Documents and Settings\All Users\Start Menu\Programs" /b | find /I "Communicator"

:INSTALLED
REM Since MS Comm is already installed, nothing else to do. Inform the user on how to log in
ECHO.
ECHO MS Communicator 2005 is already installed!
ECHO Please inform the customer how to log in with email address.
PAUSE
GOTO RESTART


:RESTART
REM Allows you to run the command again to run another remote install on another system
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

:HELP
CLS
REM Display help if no variable is specified when prompted
ECHO.
ECHO *** You forgot to enter the computer name!
ECHO *** Please enter the computer name when prompted.
ECHO *** For Example: CAD1100134  (no leading slashes)
ECHO.
REM Then take user back to the prompt
GOTO START

:PSEXEC
REM Set a blank LOCATION variable
REM SET LOCATION=
ECHO.
ECHO Please be patient while your hard drive is searched ...
ECHO.
REM Run a C: drive search to locate the psexec executable
FOR /F "tokens=*" %%i IN ('dir c:\ /s /b ^| find /I "psexec.exe"') DO SET LOCATION=%%i
REM IF executable not found, display useful info
IF ERRORLEVEL 1 GOTO NOTFOUND
REM Trim the file name from the path
SET LOCATION=%LOCATION:~0,-11%
REM Diplay the folder location
ECHO PSEXEC has been found in the following folder: 
ECHO %LOCATION%
ECHO.
GOTO START


:NOTFOUND
REM If the psexec.exe command does not exist, show helpful info
CLS
ECHO.
echo *** No PSEXEC command found on your hard drive. Please download PSTOOLS Suite from here: 
echo *** http://technet.microsoft.com/en-us/sysinternals/bb896649
echo *** and extract the files in it to your Windows folder or its own folder then add it to PATH
ECHO *** If you already have PSEXEC on your system, please make sure its location is in the PATH
ECHO.
PAUSE
GOTO END

:BATCH
REM Display warning if the install.bat file does not exists or is not accessible
ECHO *** The "install.bat" file does not exists - cannot proceed with the remote install
REM ECHO *** Please create a batch file named "install.bat" and place the following line into it (including all quotes):
REM ECHO *** "\\deltads\ddc\Packages\MICROSOFT - OFFICE COMMUNICATOR2005\Communicator_Launcher.EXE"
REM ECHO *** Then run this script again.
REM PAUSE
ECHO *** Creating "install.bat" file for you now on your Desktop ...
ECHO "\\deltads\ddc\Packages\MICROSOFT - OFFICE COMMUNICATOR2005\Communicator_Launcher.EXE" > %UserProfile%\Desktop\install.bat
GOTO INSTALL

:END
REM Nothing else to do - just exit.