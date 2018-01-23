$User = read-host -Prompt "Enter User" 
$DN=$User.DistinguishedName
"User "+ $User + " is a member of these groups:" 
# $groups = Get-DistributionGroup
# $groups | where-object { ( Get-DistributionGroupMember $_ | where-object { $_.Name -eq $User}) } 

#Get-DistributionGroup | select -Property alias | Foreach-Object {
#    Get-DistributionGroupMember S_.Alias | Foreach-Object {
#        $_.Name -eq $User
#    }
#}


#$Mailbox=get-Mailbox user@domain.com
#$DN=$mailbox.DistinguishedName
$Filter = "Members -like ""$User"""
Get-DistributionGroup -ResultSize Unlimited -Filter $Filter