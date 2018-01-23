$mailboxUser = read-host "Which User account do you want to hide in GAL?"
Set-Mailbox -Identity $mailboxUser -HiddenFromAddressListsEnabled $true
Get-Mailbox -Identity $mailboxUser | Format-List DisplayName,Name,*SMTP*,Hid*
