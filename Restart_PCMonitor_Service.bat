@ECHO OFF
net stop "PC Monitor" /Y 
ECHO Pausing ...
ping 8.8.8.8 -n 4 > NUL
net start "PC Monitor"
ECHO Pausing ...
ping 8.8.8.8 -n 4 > NUL
