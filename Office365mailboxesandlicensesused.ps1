#Requires -Version 3

$users = Get-MsolUser -All
$mailboxes = Get-Mailbox -ResultSize Unlimited
$mailstats = $mailboxes | Get-MailboxStatistics | Select-Object -Property @{l='UserName';e={$_.LegacyDN.split('-')[-1]}}, LastLogonTime

$output = foreach ($user in $users) {
    if ($user.licenses[0].accountskuid) {
        #$skuid = $user.licenses[0].accountskuid.split(':')[1]
        switch -wildcard ($user.licenses[0].accountskuid) {
            "*:DESKLESSPACK" { $license = 'K1' }
            "*:STANDARDPACK" { $license = 'E1' }
            "*:STANDARDWOFFPACK" { $license = 'E2' }
            "*:ENTERPRISEPACK" { $license = 'E3' }
            default { $license = "Unknown: $($user.licenses[0].accountskuid)" }
        }
        
        $UserName = $user.UserPrincipalName.Split('@')[0]
        [string]$CreationDate = $mailboxes | Where-Object -Filter {$_.UserPrincipalName -eq $user.UserPrincipalName} | Select-Object -ExpandProperty WhenCreated
        [string]$LastLogonDate = $mailstats | Where-Object -Filter {$_.UserName -eq $UserName}  | Select-Object -ExpandProperty LastLogonTime
        
        if ($LastLogonDate -eq $null) { $LastLogonDate = 'Never' }

        $props = [ordered]@{'DisplayName' = $user.DisplayName;
                   'UserName' = $UserName;
                   'Department' = $user.Department;
                   'CreationDate' = $CreationDate;
                   'EmailAddress' = $user.UserPrincipalName;
                   'LastLogonDate' = $LastLogonDate;
                   'License' = $license
            }
        $obj = New-Object -Type PSObject -Property $props
        Write-Output $obj
    }
}