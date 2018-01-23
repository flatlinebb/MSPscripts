# Remove the -Whatif parameters to use the commands below

# Remove all temp files for current user
Get-ChildItem $Env:Temp | Remove-Item -Recurse -Force

# Remove all temp files for ALL users
Get-ChildItem C:\Users\*\AppData\Local\Temp\* | Remove-Item -Recurse -Force

# Remove all CBS log files on the machine
Get-ChildItem C:\Windows\Logs\CBS\*.log | Remove-Item -Recurse -Force
