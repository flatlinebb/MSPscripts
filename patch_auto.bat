@echo off
cls

if %PROCESSOR_ARCHITECTURE%==x86 set arch=x86
if %PROCESSOR_ARCHITECTURE%==AMD64 set arch=x64
for /F "tokens=4-5 delims=[.] " %%A in ('ver') do set ver=%%A.%%B
set log="%~dp0\wusa-%date:~-4,4%%date:~-7,2%%date:~-10,2%-%time:~-11,2%%time:~-8,2%%time:~-5,2%.log"

echo.
echo Installing updates from "%~dp0"
echo.

for /r "%~dp0" %%m in ("*.exe") do (
set msupath=%%m
set msufile=%%~nm
call :wusa
)
echo.
echo Done! Please check %log% for results.
echo.
pause
goto :eof

:wusa
echo %msufile%
start /wait "%msupath%\%msufile%" /quiet /norestart
echo %msufile% %errorlevel% >> %log%