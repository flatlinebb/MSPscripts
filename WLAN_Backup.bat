@echo off & color e & mode con:cols=70 lines=18 & title[ ~ WLAN BACKUP AND RESTORE TOOL ~ ]
:: Set to Current Directory 
set CD=%~dp0
::====INFO====+
:: WLAN.Backup.Restore.cmd 
:: Works with Win7 - Dos_Probie.2012
::============+
:MAINMENU
cls
echo.
echo [MAIN MENU]
echo +=====================+ 
echo A.) BACKUP Wi-Fi
echo.
echo B.) RESTORE Wi-Fi
echo.
echo C.) NETWORK Info
echo.
echo D.) COMPUTER Info
echo.
echo E.) EXIT The Program
echo +=====================+ 
echo.&echo.&echo.
set choice=
set /p choice= When Ready Select: A, B, C, D, or E then press [ENTER]:
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if /I '%choice%'=='A' goto BACKUP
if /I '%choice%'=='B' goto RESTORE
if /I '%choice%'=='C' goto NETWORK
if /I '%choice%'=='D' goto INFO
if /I '%choice%'=='E' goto EOF
echo.
echo "%choice%" Key is Incorrect! Please Select Correct Key Then Try Again..
echo.
goto :mainmenu
::============+
:BACKUP
cls &color e
echo Press any [KEY] To Begin Backup ...&pause>nul&goto :bu
:bu
cls
::make directories
md "%CD%WlanBackup\reg"
md "%CD%WlanBackup\xml"
::backup registry files
reg export "hkey_local_machine\software\microsoft\Wlansvc" "%CD%WlanBackup\reg/Wlansvc.reg">nul 2>&1
reg export "hkey_local_machine\software\microsoft\windows nt\currentversion\networklist" "%CD%WlanBackup\reg/NetList.reg">nul 2>&1
reg export "hkey_current_user\software\microsoft\windows\currentversion\internet settings\wpad" "%CD%WlanBackup\reg/WPad.reg">nul 2>&1
reg export "hkey_local_machine\software\microsoft\windows\currentversion\homegroup\networklocations" "%CD%WlanBackup\reg/NetworkGroup.reg">nul 2>&1
::export profile and change to generic name 
netsh wlan export profile key=clear>nul&ren *.xml SSID.Key.xml >nul 
:copy.delete
xcopy /y/q "%CD%SSID.Key.xml" "%CD%WlanBackup\xml">nul
del "%CD%SSID.Key.xml"/q/f
echo All Wi-Fi Files have been Backed Up Successfully!
echo Note: Save your WlanBackup folder for future wlan restore.
echo.&echo.
set /p =Press [ENTER] to return to Main Menu
cls
goto :mainmenu
::============+
:RESTORE 
cls &color e
echo Press any [KEY] To Begin Restore ...&pause>nul&goto :rs
:rs
cls
:import over
reg import "%CD%WlanBackup\reg\wpad.reg">nul 2>&1
reg import "%CD%WlanBackup\reg\Wlansvc.reg">nul 2>&1
reg import "%CD%WlanBackup\reg\NetList.reg">nul 2>&1
reg import "%CD%WlanBackup\reg\NetworkGroup.reg">nul 2>&1 
:deploy profile (Connects without prompting for security key)
for /f "tokens=*" %%a IN ("%CD%WlanBackup\xml\SSID.Key.xml") do netsh wlan add profile filename="%%a">nul
echo Your Wi-Fi connection has been restored Successfully!
echo.&echo.
echo Press [ENTER] to return to Main Menu
pause >nul
cls
goto :mainmenu
::============+
:NETWORK 
cls &color e
echo Press any [KEY] To Get Network Information ...&pause>nul&goto :nw
:nw
cls
:: CK CONNECTION 127.0.0.1
ping -n 1 google.com|find "Reply from">nul
if not errorlevel 1 goto :Online
if errorlevel 1 goto :Offline
:Online
echo ==Active Internet Connection==
echo.
Echo.=========== ACTIVE CONNECTION ===========>>Network.Info.txt
:: PROFILE
set qry=reg query "HKEY_LOCAL_MACHINE\software\microsoft\windows nt\currentversion\networklist\Profiles"
set guid=reg query "HKEY_LOCAL_MACHINE\software\microsoft\windows nt\currentversion\networklist\Profiles"
for /f "delims=" %%a in ('%qry% ^| find "{"') do set var=%%~nxa &goto :gotit
:gotit
for /f "tokens=2,*" %%b in ('%guid%\%var%" ^| find "ProfileName"') do echo Your Active Profile Name Is: %%%c
:: LOG
for /f "tokens=2,*" %%b in ('%guid%\%var%" ^| find "ProfileName"') do echo =Your Active Profile Name Is: %%%c >>Network.Info.txt 
:: ISP Domain
for /f "tokens=2 delims=:" %%# In ('IPConfig /all^|Find "DNS Suffix Search List"') Do (
for %%$ In (%%#) Do Set ISPDomain=%%$)
echo=Your ISP Domain Is: %ISPDomain% 
Echo.=Your ISP-Server Is:>>Network.Info.txt %ISPDomain%
:: IP Address
for /f "tokens=2 delims=:" %%# In ('IPConfig^|Find "IPv4"') Do ( 
Call :Addy %%#) 
:Addy 
Set IP=%1 
Echo=Your IP Address Is: %IP%
Echo.=Your IP Address Is: >>Network.Info.txt %IP%
echo ==============================
Echo.=========================================>>Network.Info.txt
goto :Exit
:Offline
echo ==Non-Active Internet Connection==
echo.
:: PROFILE
set qry=reg query "HKEY_LOCAL_MACHINE\software\microsoft\windows nt\currentversion\networklist\Profiles"
set guid=reg query "HKEY_LOCAL_MACHINE\software\microsoft\windows nt\currentversion\networklist\Profiles"
for /f "delims=" %%a in ('%qry% ^| find "{"') do set var=%%~nxa & goto :gotit
:gotit
for /f "tokens=2,*" %%b in ('%guid%\%var%" ^| find "ProfileName"') do echo Your Active Profile Name Is: %%%c
:: LOG
for /f "tokens=2,*" %%b in ('%guid%\%var%" ^| find "ProfileName"') do echo Your Active Profile Name Is: %%%c>Network.Info.txt 
echo.
:: ISP Domain
set qry=reg query "HKEY_LOCAL_MACHINE\System\Currentcontrolset\services\tcpip\parameters" /v DhcpDomain
set fnd=findstr /I /L /C:"REG_SZ"
for /f "Tokens=2*" %%u in ('%qry%^|%fnd%') do (@echo %%v)
for /f "Tokens=2*" %%u in ('%qry%^|%fnd%') do (@echo>>Network.Info.txt %%v)
echo.
:: IP Address
set qry=reg query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\Tcpip\Parameters\Interfaces"
set guid=reg query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\Tcpip\Parameters\Interfaces"
for /f "delims=" %%a in ('%qry% ^| find "{"') do (
for /f "tokens=2*" %%b in ('%guid%\%%~nxa" ^| find "DhcpIPAddress"') do echo %%c)
echo.
:: LOG
set qry=reg query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\Tcpip\Parameters\Interfaces"
set guid=reg query "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\services\Tcpip\Parameters\Interfaces"
for /f "delims=" %%a in ('%qry% ^| find "{"') do (
for /f "tokens=2*" %%b in ('%guid%\%%~nxa" ^| find "DhcpIPAddress"') do echo %%c>>Network.Info.txt)
Echo======== NON-ACTIVE CONNECTION ===========>>Network.Info.txt
:Exit
echo.&echo.
echo * DONE * == Press Any [KEY] To Return To The Main Menu ==&pause>nul&goto :mainmenu
::============+
:INFO
cls &color e
echo Press any [KEY] To Get Computer Information ...&pause>nul&goto :ci
:ci
cls
:: Get Computer OS
FOR /F "tokens=2 delims='='" %%A in ('wmic os get Name /value') do SET osname=%%A
FOR /F "tokens=1 delims='|'" %%A in ("%osname%") do SET osname=%%A
:: Get Service Pack
FOR /F "tokens=2 delims='='" %%A in ('wmic os get ServicePackMajorVersion /value') do SET sp=%%A
:: Get Computer Serial Number
FOR /F "tokens=2 delims='='" %%A in ('wmic Bios Get SerialNumber /value') do SET serialnumber=%%A
:: Get Computer Manufacturer
FOR /F "tokens=2 delims='='" %%A in ('wmic ComputerSystem Get Manufacturer /value') do SET manufacturer=%%A
:: Get Computer Model
FOR /F "tokens=2 delims='='" %%A in ('wmic ComputerSystem Get Model /value') do SET model=%%A
:: Get Computer Name
FOR /F "tokens=2 delims='='" %%A in ('wmic OS Get csname /value') do SET system=%%A
echo COMPUTER INFORMATION
echo ====================
echo O.S.: %osname%
echo Service Pack: %sp%
echo Serial Number: %serialnumber%
echo Manufacturer: %manufacturer%
echo Model: %model%
echo System Name: %system%
echo ====================
echo.
:: Generate file
SET file="%~dp0%computername%.txt"
echo ===Computer Info=== > %file%
echo Details For %computer%: >> %file%
echo System Name: %system% >> %file%
echo Manufacturer: %manufacturer% >> %file%
echo Model: %model% >> %file%
echo Serial Number: %serialnumber% >> %file%
echo Operating System: %osname% >> %file%
echo Service Pack: %sp% >> %file%
Systeminfo >> %file% 
echo.&echo.
echo * DONE * == Press Any [KEY] To Return To The Main Menu ==&pause>nul&goto :mainmenu
::============+
:EOF
REM echo.
REM set /p =CLOSING MENU In: <nul
REM for /l %%a in (5 -1 1) do (
REM set /p =%%a Seconds... <nul&ping -n 2 127.1 >nul
REM )
exit,0
::===========+
::rev. 10.04.12