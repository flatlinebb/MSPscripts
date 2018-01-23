@ECHO OFF
ECHO ____________________________________
ECHO.
ECHO %date% %time%
ECHO.
ECHO Checking Mail Store Status ...
ECHO.
cscript //NoLogo "C:\Script\Store.vbs" status COS5 "First Storage Group" "Mailbox Store (COS5)"
ECHO.
