$distrGroup = read-host "Which Distro Group do you want to remove user from?"
$mailboxUser = read-host "Which User do you want to remove from $distrGroup? (enter name, email or alias)"

Remove-DistributionGroupMember -Identity $distrGroup -Member $mailboxUser
Get-DistributionGroupMember -Identity $distrGroup | select DisplayName,PrimarySmtpAddress | sort -Property DisplayName