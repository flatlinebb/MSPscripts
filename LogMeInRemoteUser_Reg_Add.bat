## This script adds and then hides a local admin user 'LogMeInRemoteUser' used for the LogMeIn agent.
##
# Create new local account 'LogMeInRemoteUser'. Does NOT set a password for the new account!
net user LogMeInRemoteUser /ADD
# Adds user account to local admin group
net localgroup Administrators LogMeInRemoteUser /add
# Adds a registry key to hide the account from the Windows logon screen
reg add "HKEY_Local_Machine\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v LogMeInRemoteUser /t REG_DWORD /d 0 /f
# Confirms that the key was added properly
reg query "HKEY_Local_Machine\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" /v LogMeInRemoteUser
# Confirms that the user account was added properly
net user LogMeInRemoteUser
# Pauses the screen so the output can be reviewed
pause
