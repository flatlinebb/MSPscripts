$nameContact = read-host "What is the name of the person you want to add?"
$emailContact = read-host "What is their email address?"

New-MailContact -Name "$nameContact" -ExternalEmailAddress "$emailContact"
Get-MailContact -Identity "$nameContact" | select Name,ExternalEmailAddress,RecipientType