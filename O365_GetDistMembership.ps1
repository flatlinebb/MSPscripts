$User = read-host "Enter Username" 
"User " + $User + " is a member of the following groups:"
ForEach ($Group in Get-DistributionGroup -resultsize unlimited) 
{ 
   ForEach ($Member in Get-DistributionGroupMember -Identity $Group | Where { $_.Name -eq $User }) 
   { 
      $Group.Name 
   } 
}