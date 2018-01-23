$mailboxUser = read-host "Which User do you want to look up? (enter email)"

# (Get-MsolUser -UserPrincipalName $mailboxUser).Licenses.ServiceStatus
(Get-MsolUser -UserPrincipalName $mailboxUser).Licenses | Select -ExpandProperty AccountSkuId