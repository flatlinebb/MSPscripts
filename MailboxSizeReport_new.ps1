Param(
    [Parameter(Mandatory=$false)]
    [PSCredential]$Office365Credential,

    [Parameter(Mandatory=$false)]
    [string]$ReportPath = "C:\Temp\O365",

    [Parameter(Mandatory=$false)]
    [string]$ToEmail = "shudda@flexmanage.com",

    [Parameter(Mandatory=$false)]
    [string]$FromEmail = "administrator@mbflegal.com"
)

if ($null -eq $Office365Credential) {
    $Office365Credential = Get-Credential
}

$s = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.outlook.com/powershell -Credential $Office365Credential -Authentication Basic -AllowRedirection
$importresults = Import-PSSession $s
Import-Module msonline
Connect-MsolService -Credential $Office365Credential
$date = Get-Date -Format "MM-dd-yyyy"
$Mailboxes = Get-Mailbox -ResultSize Unlimited | where {$_.RecipientTypeDetails -ne "DiscoveryMailbox"}

# Bulk fetch Mailbox Statistics and MSOL Users to avoid N+1 queries
$AllMailboxStats = $Mailboxes | Get-MailboxStatistics
$MailboxStatsDict = @{}
foreach ($stat in $AllMailboxStats) {
    # Get-MailboxStatistics objects usually have Identity or MailboxGuid or DisplayName.
    # In Office365, MailboxGuid is unique.
    if ($null -ne $stat.MailboxGuid) {
        $MailboxStatsDict[$stat.MailboxGuid.ToString()] = $stat
    } elseif ($null -ne $stat.DisplayName) {
        $MailboxStatsDict[$stat.DisplayName] = $stat
    }
}

$AllMsolUsers = Get-MsolUser -All
$MsolUsersDict = @{}
foreach ($user in $AllMsolUsers) {
    if ($null -ne $user.UserPrincipalName) {
        $MsolUsersDict[$user.UserPrincipalName] = $user
    }
}

$MSOLDomain = Get-MsolDomain | where {$_.Authentication -eq "Managed" -and $_.IsDefault -eq "True"}
$MSOLPasswordPolicy = Get-MsolPasswordPolicy -DomainName $MSOLDomain.name
$MSOLPasswordPolicy = $MSOLPasswordPolicy.ValidityPeriod.ToString()
$Report = @(foreach ($mailbox in $Mailboxes) {
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
$Information
})
$CsvPath = Join-Path $ReportPath "Office365MailboxSizeReport.csv"
$HtmlPath = Join-Path $ReportPath "Office365MailboxSizeReport.html"
$Report | export-csv $CsvPath -NoTypeInformation
Import-CSV $CsvPath | ConvertTo-Html -head $a -body "<html><body>O365 Report for Customer<br><img src=`"FM.gif`"></body></html>" | Out-File $HtmlPath
$attachment = Get-ChildItem $ReportPath | Where-Object { $_.Extension -eq ".html" } | Select-Object -Last 1
$attachment1 = Get-ChildItem $ReportPath | Where-Object { $_.Extension -eq ".gif" } | Select-Object -Last 1
Send-MailMessage -To $ToEmail -From $FromEmail -Subject "Monthly Office 365 Mailbox Size Report" -Body "The monthly mailbox size report is attached to this message as a CSV file." -SmtpServer outlook.office365.com -Credential $Office365Credential -UseSsl -Attachments $attachment,$attachment1
Remove-PSSession $s
