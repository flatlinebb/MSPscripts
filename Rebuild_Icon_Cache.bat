:: Created by: Shawn Brink
:: http://www.sevenforums.com
:: Tutorial:  http://www.sevenforums.com/tutorials/49819-icon-cache-rebuild.html


@echo off
cls
echo The Explorer process must be killed to delete the Icon DB. 
echo.
echo Please SAVE ALL OPEN WORK before continuing.
echo.
pause
echo.
taskkill /IM explorer.exe /F 
echo.
echo Attempting to delete Icon DB...
If exist %userprofile%\AppData\Local\IconCache.db goto delID
echo.
echo Icon DB has already been deleted. 
echo.
goto main

:delID
cd /d %userprofile%\AppData\Local
del IconCache.db /a
echo.
pause
echo Icon DB has been successfully deleted.
echo.

:main
echo Windows 7 must be restarted to rebuild the Icon DB.
echo.

:wrong 
set /p choice=Restart now? (Y/N) and press Enter:
If %choice% == y goto Yes
If %choice% == Y goto Yes
If %choice% == n goto No
If %choice% == N goto No
goto wrong

:Yes
shutdown /R /f /t 00
exit


:No
echo.
echo Restart aborted. Please remember to restart the computer later.
echo.
echo You can now close this command prompt window.
explorer.exe



