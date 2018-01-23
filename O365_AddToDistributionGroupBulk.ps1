$csvlist = read-host "Path of CSV file with member names?"

Import-CSV $csvlist | foreach{Add-DistributionGroupMember -Identity $_.identity -Member $_.members}
# Import-CSV $csvlist | Get-DistributionGroupMember -Identity $csvlist.identity

