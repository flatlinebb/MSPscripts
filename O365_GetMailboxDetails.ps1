$mailboxUser = read-host "Which User do you want to look up? (enter name, email or alias)"

#(Get-MsolUser -UserPrincipalName $mailboxUser).Licenses.ServiceStatus

get-mailbox -Identity $mailboxUser -IncludeInactiveMailbox | Select-Object DisplayName, UserPrincipalName, Alias, Identity, Name, DistinguishedName, PrimarySmtpAddress, EmailAddresses, WindowsEmailAddress, RecipientType, OrganizationalUnit, HiddenFromAddressListsEnabled, MaxSendSize, MaxReceiveSize, GrantSendOnBehalfTo, ExternalOofOptions, ForwardingAddress, ForwardingSmtpAddress, IsMailboxEnabled, AccountDisabled, IsValid, IsShared, MailboxPlan, WhenChanged, WhenCreated