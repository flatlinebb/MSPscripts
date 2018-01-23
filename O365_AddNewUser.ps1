$userFirstName = read-host "New User First Name?"
$userLastName = read-host "New User Last Name?"
$userEmail = read-host "New User Email Address?"
$userPass = read-host "New User Password? (ENTER for Random Password)"

New-MsolUser -UserPrincipalName $userEmail -DisplayName "$userFirstName $userLastName" -FirstName "$userFirstName" -LastName "$userLastName" -Password "$userPass" -PasswordNeverExpires $true -LicenseAssignment "NovaPartnersInc:O365_BUSINESS_ESSENTIALS" -UsageLocation "US"

Get-MsolUser -UserPrincipalName $userEmail | Select-Object DisplayName,UserPrincipalName,IsLicensed,Licenses,PasswordNeverExpires,WhenCreated