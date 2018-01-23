@ECHO OFF
net stop Server /Y 
ECHO Pausing ...
ping 8.8.8.8 -n 4 > NUL
net start Server 
ECHO Pausing ...
ping 8.8.8.8 -n 4 > NUL
net start "Computer Browser"
ECHO Pausing ...
ping 8.8.8.8 -n 4 > NUL