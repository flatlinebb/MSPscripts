@ECHO OFF
CLS
REM REM -------------------------------------------------------------
REM REM ---------------Silent Install Master Batch-------------------
REM REM -------------------------------------------------------------
REM REM -----------Written by Bart Boryczko on 10/07/2010------------
REM REM -------------------------------------------------------------
REM REM This script will launch a CLI menu that will facilitate 
REM REM installing and launching of various utilities and software.
REM REM It is primarily recommended for updating/deploying old of PCs.
REM REM The source installers reside on Bart's workstation, in a shared
REM REM folder called "Bart_Downloads".
REM REM Eventually it should be moved to a Domain File Server, to free up
REM REM space and resources on the local workstation.
REM REM ***************
REM REM Usage:
REM REM ***************
REM REM Launch the batch file, either directly from the network share:
REM REM \\192.168.1.122\Bart_Downloads\Silent Install Batch Files\silent_install_master_menu.bat
REM REM or copy the batch file to the local system then double-click.
REM REM Follow the prompts on the screen to use various functions.
REM REM Please note that if you copy the batch file locally, it will not be updated
REM REM if changes are made to the script.
REM REM It is more practical to create a shortcut on the local PC to the network location
REM REM of the script. That way it will alway spoint to the latest version of the script.

:MENU
CLS
ECHO -----------------------------------------------------------------------------------------
ECHO                         ========= IT Install Menu ===========
ECHO -----------------------------------------------------------------------------------------
ECHO.
ECHO  1.  Install CCleaner Slim 2.36                15.  Launch Windows Update Site
ECHO  2.  Install Acrobat Reader 9.4                16.  Launch FileHippo.com Update Checker
ECHO  3.  Install Thunderbird 3.1.4                 17.  Copy IObitUninstaller/SAS to Desktop
ECHO  4.  Install Firefox 3.6.10                    18.  Launch HostsFileReader.exe
ECHO  5.  Remove Speech Toolbar                     19.  Run Ninite Flash Flash IE Installer
ECHO  6.  Install UPHClean                          20.  Launch Windows Add/Remove Wizard
ECHO  7.  Install MyDefrag 4.3.1                    21.  Install CutePDF Printer
ECHO  8.  Install CmdHere Powertoy                  22.  Schedule a Full Disk Check
ECHO  9.  Install Malwarebytes Anti-Malware
ECHO 10.  Install 7zip
ECHO 11.  Install File Format Converter
ECHO 12.  Install Internet Explorer 8.0
ECHO 13.  Run ICS Sweep
ECHO 14.  Browse Downloads Folder
ECHO.
ECHO -----------------------------------------------------------------------------------------
ECHO =======PRESS 'Q' TO QUIT========PRESS 'C' FOR CMD PROMPT=======PRESS X TO REBOOT=========
ECHO -----------------------------------------------------------------------------------------
ECHO.

SET INPUT=
SET /P INPUT=Please select a number: 

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='6' GOTO Selection6
IF /I '%INPUT%'=='7' GOTO Selection7
IF /I '%INPUT%'=='8' GOTO Selection8
IF /I '%INPUT%'=='9' GOTO Selection9
IF /I '%INPUT%'=='10' GOTO Selection10
IF /I '%INPUT%'=='11' GOTO Selection11
IF /I '%INPUT%'=='12' GOTO Selection12
IF /I '%INPUT%'=='13' GOTO Selection13
IF /I '%INPUT%'=='14' GOTO Selection14
IF /I '%INPUT%'=='15' GOTO Selection15
IF /I '%INPUT%'=='16' GOTO Selection16
IF /I '%INPUT%'=='17' GOTO Selection17
IF /I '%INPUT%'=='18' GOTO Selection18
IF /I '%INPUT%'=='19' GOTO Selection19
IF /I '%INPUT%'=='20' GOTO Selection20
IF /I '%INPUT%'=='21' GOTO Selection21
IF /I '%INPUT%'=='22' GOTO Selection22
IF /I '%INPUT%'=='C' GOTO CMD
IF /I '%INPUT%'=='X' GOTO REBOOT
IF /I '%INPUT%'=='Q' GOTO Quit

CLS

ECHO -------------------------------------
ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu [1-13] or select 'Q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======
ECHO -------------------------------------

PAUSE > NUL
GOTO MENU

:Selection1
REM REM CCleaner Slim Silent Install
ECHO Running CCleaner Slim Silent Install
\\192.168.1.122\Bart_Downloads\ccsetup236_slim.exe /S
GOTO MENU

:Selection2
REM REM Acrobat Reader 9.4
ECHO Running Acrobat Reader 9.4 Silent Install
\\192.168.1.122\Bart_Downloads\AdbeRdr940_en_US.exe /sPB /rs /msi /qb /norestart EULA_ACCEPT=YES
GOTO MENU

:Selection3
REM REM Thunderbird 3.1.4 Silent Install
ECHO Running Thunderbird Silent Install
"\\192.168.1.122\Bart_Downloads\Thunderbird Setup 3.1.4.exe" /S INI=\\192.168.1.122\Bart_Downloads\thunderbird.ini
REM REM Copy the Lightning Extension to the global Thunderbird Extensions folder
:COPY
IF EXIST C:\WINDOWS\system32\xcopy.exe GOTO EXISTS
REM REM ELSE run copy command
cd "C:\Program Files\Mozilla Thunderbird\extensions"
copy /Y /Z \\192.168.1.122\Bart_Downloads\lightning-1.0b2-tb-win.xpi .
PAUSE
"C:\Program Files\Mozilla Thunderbird\thunderbird.exe"
GOTO MENU
:EXISTS
REM REM ECHO XCOPY FOUND!
cd "C:\Program Files\Mozilla Thunderbird\extensions"
xcopy \\192.168.1.122\Bart_Downloads\lightning-1.0b2-tb-win.xpi . /C /Y /Z
PAUSE
"C:\Program Files\Mozilla Thunderbird\thunderbird.exe"
GOTO MENU

:Selection4
REM REM Firefox 3.6.10
ECHO Running Firefox 3.6.10 Silent Install
\\192.168.1.122\Bart_Downloads\Firefox_{Mozilla}_3.6.10_Silent.exe
ECHO Launching FireFox for the first time
"C:\Program Files\Mozilla Firefox\firefox.exe"
GOTO MENU

:Selection5
REM REM Remove Speech Toolbar
ECHO Removing Speech Toolbar
call \\192.168.1.122\Bart_Downloads\Remove_Language_Bar.bat
GOTO MENU

:Selection6
REM REM UPHClean Setup
ECHO Running UPHClean Silent Setup
\\192.168.1.122\Bart_Downloads\UPHClean-Setup.msi /passive /norestart
GOTO MENU

:Selection7
REM REM MyDefrag 4.3.1
ECHO Running MyDefrag 4.3.1 Silent Setup
\\192.168.1.122\Bart_Downloads\MyDefrag-v4.3.1.exe /SP /Silent /NORESTART /LOADINF=\\192.168.1.122\Bart_Downloads\mydefrag.inf
GOTO MENU

:Selection8
REM REM CmdHere Powertoy
ECHO Running CmdHere Powertoy Silent Install
\\192.168.1.122\Bart_Downloads\cmdherepowertoysetup.exe /S /v/qn
GOTO MENU

:Selection9
REM REM MBAM Setup
ECHO Running MBAM Silent Install
REM REM \\192.168.1.122\Bart_Downloads\mbam-setup-1.46.exe /SP- /SILENT /NORESTART /SUPPRESSMSGBOXES /NOCANCEL
\\192.168.1.122\Bart_Downloads\mbam-setup-1.46.exe /SP- /SILENT /NORESTART /NOCANCEL
ECHO.
ECHO Launching MBAM Update
"C:\Program Files\Malwarebytes' Anti-Malware\mbam.exe" /update
GOTO MENU

:Selection10
REM REM 7zip Silent install
ECHO Running 7zip Silent install
\\192.168.1.122\Bart_Downloads\7z916.exe /S
GOTO MENU

:Selection11
REM REM File Format Convert Install
ECHO Running File Format Convert Install
\\192.168.1.122\Bart_Downloads\FileFormatConverters.exe /passive /norestart
GOTO MENU

:Selection12
REM REM Internet Explorer 8.0
ECHO Running Internet Explorer 8.0 Silent Setup
REM REM \\192.168.1.122\Bart_Downloads\IE8-WindowsXP-x86-ENU.exe /passive /norestart
\\192.168.1.122\Bart_Downloads\Custom_IE8_Build\FLAT\WIN32_XP\EN\IE8-Setup-Full.exe
GOTO MENU

:Selection13
REM REM ICS Sweep Batch
ECHO Running ICS Sweep Cleanup
"\\192.168.1.122\Bart_Downloads\ICSweep\ICSweep.exe" /SIZE
pause
"\\192.168.1.122\Bart_Downloads\ICSweep\ICSweep.exe" /ALL
pause
"\\192.168.1.122\Bart_Downloads\ICSweep\ICSweep.exe" /SIZE
pause
GOTO MENU

:Selection14
REM REM Open the Downloads folder
ECHO Opening the Downloads folder
start \\192.168.1.122\Bart_Downloads
GOTO MENU

:Selection15
REM REM Launch the Windows Update website in the default browser.
ECHO Launching Windows Update website
start http://www.update.microsoft.com
GOTO QUIT

:Selection16
REM REM Launch the FileHippo.com Update Checker
ECHO Launching the FileHippo.com Update Checker
"\\192.168.1.122\Bart_Downloads\UpdateChecker.exe"
GOTO MENU

:Selection17
REM REM Copy IObit/SAS to Desktop
ECHO Copying Utils to local Desktop folder
mkdir "%USERPROFILE%\Desktop\Bart Tools"

:COPY
IF EXIST C:\WINDOWS\system32\xcopy.exe GOTO EXISTS
REM ELSE
cd "%USERPROFILE%\Desktop\Bart Tools"
copy /Y /Z \\192.168.1.122\Bart_Downloads\iobituninstaller.exe .
copy /Y /Z \\192.168.1.122\Bart_Downloads\SAS_298421F5.COM .
copy /Y /Z \\192.168.1.122\Bart_Downloads\SASUNINST.EXE .
PAUSE
GOTO MENU

:EXISTS
ECHO XCOPY FOUND!
cd "%USERPROFILE%\Desktop\Bart Tools"
xcopy \\192.168.1.122\Bart_Downloads\iobituninstaller.exe . /C /Y /Z
xcopy \\192.168.1.122\Bart_Downloads\SAS_298421F5.COM . /C /Y /Z
xcopy \\192.168.1.122\Bart_Downloads\SASUNINST.EXE . /C /Y /Z
PAUSE
GOTO MENU


:Selection18
REM REM Launch the Hosts File Reader
ECHO Launching the Hosts File Reader
\\192.168.1.122\Bart_Downloads\HostsFileReader.exe
GOTO MENU

:Selection19
REM REM Run the Ninite Flash Installer
ECHO Running the Ninite Flash Installer
"\\192.168.1.122\Bart_Downloads\Ninite Flash Flash IE Installer.exe" /silent "%USERPROFILE%\Desktop\Bart Tools\report.txt"
notepad.exe "%USERPROFILE%\Desktop\Bart Tools\report.txt"
GOTO MENU

:Selection20
REM REM Launch Windows Add/Remove Wizard
ECHO Starting Add/Remove Wizard
control appwiz.cpl
GOTO MENU

:Selection21
REM REM Install CutePDF Printer
ECHO Running GhostScript Converter Setup
"\\192.168.1.122\Bart_Downloads\CutePDF Install Files\converter\Setup.exe"
ECHO Running CutePDF Printer Installer
"\\192.168.1.122\Bart_Downloads\CutePDF Install Files\Setup.exe" /cpw07012009 /W1
GOTO MENU

:Selection22
REM REM Schedule a Full Disk Check
ECHO Running the Disk Check command
chkdsk C: /F /V /R
GOTO MENU


:CMD
REM REM Open a Command Line prompt
ECHO Launching a CMD prompt
start cmd.exe /K
GOTO MENU

:REBOOT
REM REM This will restart the computer
ECHO.
ECHO ARE YOU SURE YOU WANT TO REBOOT?!?!
ECHO.
SET /P C=Please select (Y)es or (N)o: 
REM set /P C=[Y,N]?
REM IF /I '%INPUT%'=='X' GOTO REBOOT
if /I "%C%"=="Y" goto YES
if /I "%C%"=="N" goto NO
GOTO MENU

:YES
CLS 
ECHO Rebooting now ...
shutdown.exe -r -t 1 -f -c "Reboot after installing software/updates"
EXIT

:NO
ECHO Aborting Reboot ...
GOTO MENU


:QUIT
CLS

ECHO -------------------------------------
ECHO ============= THANK YOU =============
ECHO -------------------------------------
ECHO ===== PRESS ANY KEY TO CONTINUE =====
ECHO -------------------------------------

REM REM PAUSE>NUL
EXIT
