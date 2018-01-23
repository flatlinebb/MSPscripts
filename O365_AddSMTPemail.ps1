$nameContact = read-host "What is the name of the person?"
$emailContact = read-host "What is their new email address?"

Set-Mailbox "$nameContact" -EmailAddresses @{add="$emailContact"}
Get-Mailbox "$nameContact" | fl EmailAddresses