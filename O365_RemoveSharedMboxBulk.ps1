$csvlist = read-host "Path of CSV file with user names?"
Import-CSV $csvlist | foreach{Remove-MailboxPermission -Identity $_.identity -User $_.user -AccessRights FullAccess}                           
Import-CSV $csvlist | Get-MailboxPermission $csvlist[0].identity | Select-Object Identity,User | findstr /i "@"
