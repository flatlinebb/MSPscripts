@echo off 
TITLE Dell Backup and Recovery Manager Tray Icon Removal Tool
echo.
echo --------------------------------------------------------------------------------
echo                ::: Removing Dell Backup Manager and Tray Icon :::
echo --------------------------------------------------------------------------------
timeout /t 3 /NOBREAK > nul
cls
echo.
echo --------------------------------------------------------------------------------
echo                      Killing "DbrmTrayicon.exe" Process...
echo --------------------------------------------------------------------------------
echo.
taskkill /F /IM DbrmTrayicon.exe  /T
timeout /t 3 /NOBREAK > nul
cls
echo.
echo --------------------------------------------------------------------------------
echo        Changing Directory to C:\Dell and Removing .ini and DBRM Directory
echo --------------------------------------------------------------------------------
echo.
cd C:\dell
del C:\dell\DBRM.ini /Q
rd C:\dell\DBRM /S /Q
timeout /t 3 /NOBREAK > nul
cls
echo.
echo --------------------------------------------------------------------------------
echo                  Deleting Registry Key that Runs DBRM Tray Icon
echo --------------------------------------------------------------------------------
echo.
reg DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run /v DBRMTray /f
timeout /t 3 /NOBREAK > nul
cls
echo.
echo --------------------------------------------------------------------------------
echo             Removing Dell Backup and Recovery Manager via WMIC call            
echo --------------------------------------------------------------------------------
echo.
REM  You can REM or remove the line below if you wish to keep the DBRM program installed
WMIC product where name="Dell Backup and Recovery Manager" call uninstall /nointeractive
timeout /t 3 /NOBREAK > nul
cls
echo.
echo --------------------------------------------------------------------------------
echo                             Process is Now Complete!
echo --------------------------------------------------------------------------------
timeout /t 3 /NOBREAK > nul
exit