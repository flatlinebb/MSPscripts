cd C:\Temp\O365
$password = Get-Content C:\Temp\O365\Office365cred.txt | ConvertTo-SecureString
echo $password
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList administrator@mbflegal.com,$password
$s = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $cred -Authentication Basic -AllowRedirection
$importresults = Import-PSSession $s
Import-Module msonline 
Connect-MsolService -Credential $Cred
$date = Get-Date -Format "MM-dd-yyyy"
$Report=@()
$Mailboxes = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -ne "DiscoveryMailbox"}
$MSOLDomain = Get-MsolDomain | where {$_.Authentication -eq "Managed" -and $_.IsDefault -eq "True"}
$MSOLPasswordPolicy = Get-MsolPasswordPolicy -DomainName $MSOLDomain.name
$MSOLPasswordPolicy = $MSOLPasswordPolicy.ValidityPeriod.ToString()
foreach ($mailbox in $Mailboxes) {
$DaysToExpiry = @()
$DisplayName = $mailbox.DisplayName
$UserPrincipalName  = $mailbox.UserPrincipalName
$UserDomain = $UserPrincipalName.Split('@')[1]
$Alias = $mailbox.alias
$MailboxStat = Get-MailboxStatistics $UserPrincipalName
$LastLogonTime = $MailboxStat.LastLogonTime 
$TotalItemSize = $MailboxStat | select @{name="TotalItemSize";expression={[math]::Round(($_.TotalItemSize.ToString().Split("(")[1].Split(" ")[0].Replace(",","")/1MB),2)}}
$TotalItemSize = $TotalItemSize.TotalItemSize
$RecipientTypeDetails = $mailbox.RecipientTypeDetails
$MSOLUSER = Get-MsolUser -UserPrincipalName $UserPrincipalName
if ($UserDomain -eq $MSOLDomain.name) {$DaysToExpiry = $MSOLUSER |  select @{Name="DaysToExpiry"; Expression={(New-TimeSpan -start (get-date) -end ($_.LastPasswordChangeTimestamp + $MSOLPasswordPolicy)).Days}}; $DaysToExpiry = $DaysToExpiry.DaysToExpiry}
$Information = $MSOLUSER | select FirstName,LastName,@{Name='DisplayName'; Expression={[String]::join(";", $DisplayName)}},@{Name='Alias'; Expression={[String]::join(";", $Alias)}},@{Name='UserPrincipalName'; Expression={[String]::join(";", $UserPrincipalName)}},Office,Department,@{Name='TotalItemSize (MB)'; Expression={[String]::join(";", $TotalItemSize)}},@{Name='LastLogonTime'; Expression={[String]::join(";", $LastLogonTime)}},LastPasswordChangeTimestamp,@{Name="PasswordExpirationIn (Days)"; Expression={[String]::join(";", $DaysToExpiry)}},@{Name='RecipientTypeDetails'; Expression={[String]::join(";", $RecipientTypeDetails)}},islicensed,@{Name="Licenses"; Expression ={$_.Licenses.AccountSkuId}} 
$Report = $Report+$Information
}
$Report | export-csv "C:\Temp\O365\Office365MailboxSizeReport.csv" -NoTypeInformation
Import-CSV "C:\Temp\O365\Office365MailboxSizeReport.csv" | ConvertTo-Html -head $a -body "<html><body>O365 Report for Customer<br><img src=`"FM.gif`"></body></html>" | Out-File "C:\temp\O365\Office365MailboxSizeReport.html"
$attachment = Get-ChildItem C:\Temp\O365 | Where-Object { $_.Extension -eq ".html" } | Select-Object -Last 1
$attachment1 = Get-ChildItem C:\Temp\O365 | Where-Object { $_.Extension -eq ".gif" } | Select-Object -Last 1
Send-MailMessage -To shudda@flexmanage.com -From administrator@mbflegal.com -Subject "Monthly Office 365 Mailbox Size Report" -Body "The monthly mailbox size report is attached to this message as a CSV file." -SmtpServer outlook.office365.com -Credential $cred -UseSsl -Attachments $attachment,$attachment1
Remove-PSSession $s
