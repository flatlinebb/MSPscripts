$res_type = read-host "What type of Resource do you need: Room or Equipment? (Use Upper Case)"
$res_name = read-host "Which Name do you want to assign this Resource? (w/o quotes)"

New-Mailbox -Name "$res_name" -$res_type
Set-CalendarProcessing "$res_name" -AutomateProcessing AutoAccept
Set-CalendarProcessing "$res_name" -AddOrganizerToSubject $True -DeleteComments $False -DeleteSubject $False

Get-Mailbox -Filter '(RecipientTypeDetails -eq "$res_typeMailBox")' | Select Name,Alias,Type | Sort -Property Name
