$junkUser = read-host "What email address would you like to block?"

Get-Mailbox -ResultSize Unlimited | Set-MailboxJunkEmailConfiguration  -Verbose -BlockedSendersAndDomains "$junkUser"