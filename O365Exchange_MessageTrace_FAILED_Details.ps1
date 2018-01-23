$dateEnd = get-date 
$dateStart = $dateEnd.AddHours(-48)

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Where {$_.Status -eq "Failed"} | Get-MessageTraceDetail | Select-Object MessageID, Date, Event, Action, Detail, Data | Out-GridView
