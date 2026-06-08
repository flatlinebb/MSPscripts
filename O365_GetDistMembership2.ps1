$User = read-host -Prompt "Enter User" 
$DN=$User.DistinguishedName
"User "+ $User + " is a member of these groups:" 

$Filter = "Members -like ""$User"""
Get-DistributionGroup -ResultSize Unlimited -Filter $Filter