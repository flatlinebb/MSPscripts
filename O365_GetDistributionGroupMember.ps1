$distrGroup = read-host "Enter Distro Group Name? " 
Get-DistributionGroupMember -Identity $distrGroup | Select DisplayName,PrimarySmtpAddress | Sort -Property DisplayName