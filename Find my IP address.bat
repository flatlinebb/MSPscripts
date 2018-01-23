@ECHO OFF
echo My IP address is: 
ipconfig /all | find /I "IP Address" | find /V "192.168.1."
ipconfig /all | find /I "IPv4 Address" | find /V "192.168.1."
pause