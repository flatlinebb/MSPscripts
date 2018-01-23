$userName = read-host "Which user?"
$mboxName = read-host "Which Mailbox?"
Add-MailboxPermission -Identity $mboxName -User $userName -AccessRights FullAccess
Get-MailboxPermission $mboxName | Select-Object Identity, User | findstr /i "@"