$distrGroup = read-host "Which Distro Group do you want to add user to?"
$mailboxUser = read-host "Which User do you want to add to this group? (enter name, email or alias)"

Add-DistributionGroupMember -Identity $distrGroup -Member $mailboxUser
Get-DistributionGroupMember -Identity $distrGroup | Select DisplayName,PrimarySmtpAddress | Sort -Property DisplayName
