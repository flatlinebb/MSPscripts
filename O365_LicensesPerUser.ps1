$UserLicFile="C:\UserLicensesPerUser.CSV"
IF (test-Path $UserLicFile)
{
Remove-Item $UserLicFile
}
$STR = "User Principal Name, Office 365 Plan, Office 365 Service,Service Status"
Add-Content $UserLicFile $STR
$GetAllUsers=Get-MsolUser -All | Select-Object UserPrincipalName -ExpandProperty Licenses
ForEach ($AllU in $GetAllUsers)
{
$SelUserUPN = $AllU.UserPrincipalName
$T = $AllU
$i = 0
ForEach ($AllITems in $T)
{
$T.Count
$T[$i].AccountSkuId
$Account = $T[$i].AccountSkuId
$TTT = $T[$i].ServiceStatus
ForEach ($AllR in $TTT)
{
$GR = $AllR.ServicePlan.ServiceType
$GZ = $AllR.ProvisioningStatus
$STRNow = $SelUserUPN + "," + $Account + "," + $GR + "," + $GZ
Add-Content $UserLicFile $STRNow
}
$i = $i + 1
}
}