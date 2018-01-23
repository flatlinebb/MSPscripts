@ECHO OFF
set a=%1
echo.
echo File to Download: %a%
echo.
set currdir="%cd%"
echo Current Folder: %currdir%
echo.
timethis aria2c.exe -s 5 --min-split-size=10MB -c --check-certificate=false -Z --file-allocation=none --max-connection-per-server=5 --truncate-console-readout=false --no-conf=true --seed-ratio=0 --seed-time=0 --dir=./  "%a%"

D:\Bart\Dropbox\Notes\Pushover_curl.bat