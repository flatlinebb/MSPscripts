$userName = read-host "Which user give access to (give full email address)?"
$mboxName = read-host "Which Shared Mailbox to give access to $userName?"
Add-MailboxPermission -Identity $mboxName -User $userName -AccessRights FullAccess
Get-MailboxPermission $mboxName | Select-Object Identity, User | findstr /i "@"