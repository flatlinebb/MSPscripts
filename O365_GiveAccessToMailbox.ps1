$mailboxAccess = read-host "Which mailbox do you want to give full access to?"
$mailboxUser = read-host "Which user do you want to give access to $mailboxAccess to (give full email address)?"
 
Add-MailboxPermission $mailboxAccess -User $mailboxUser -AccessRights FullAccess -InheritanceType All

Get-MailboxPermission $mailboxAccess | Select-Object User,AccessRights | findstr "@"