@echo off
ipconfig /all | find /i "Host Name"
ipconfig /all | find "IP" | find /v "IPv6"
ipconfig /all | find /i "Subnet"
ipconfig /all | find /i "DNS"
pause

