$dateEnd = get-date 
$dateStart = $dateEnd.AddHours(-48)

Get-MessageTrace -StartDate $dateStart -EndDate $dateEnd | Select-Object Received, SenderAddress, RecipientAddress, Subject, Status, ToIP, FromIP, Size, MessageID, MessageTraceID | Where {$_.Status -eq "Failed"} | Out-GridView