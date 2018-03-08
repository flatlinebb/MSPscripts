##
# Put this in the shortut in shell:StartUp (C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup)
# Target: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "C:\Users\Administrator\Downloads\wuinstall.ps1"
# Start in: C:\Users\Administrator\Downloads
##

param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

##
# Put this in the shortut in shell:StartUp
# C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
# C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -Command "C:\Users\Administrator\Downloads\wuinstall.ps1"
# Start in: C:\Users\Administrator\Downloads
##

param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

Add-WUServiceManager -ServiceID 7971f918-a847-4430-9279-4a52d1efe18d -Confirm:$false

Write-Host "Hiding junk updates for Bing and Skype ..."
Hide-WUUpdate -Title "Bing*,Skype*,Internet*" -MicrosoftUpdate -Confirm:$false
Write-Host "Hiding MS Essentials updates: KB3140479,KB2902907,KB2876229  ...."
Hide-WUUpdate -KBArticleID "KB3140479,KB2902907,KB2876229,KB2673774,KB2673773,KB2673772,KB2673771,KB2673770,KB2626808,KB2626806,KB2626807,KB2626804,KB2617376" -MicrosoftUpdate -Confirm:$false
Write-Host "Hiding Driver updates: ..."
Hide-WUUpdate -UpdateType Driver -MicrosoftUpdate -Confirm:$false

Write-Host "Hiding Preview Updates: ..."
Hide-WUUpdate -Title "Preview*" -MicrosoftUpdate -Confirm:$false

Write-Host "Starting Updates ..."
Get-WUInstall -MicrosoftUpdate -AutoReboot -AcceptAll -Confirm:$false

###
# Bing Bar 7.1 KB2673774
# Bing Bar 7.1 KB2673773
# Bing Bar 7.1 KB2673772
# Bing Bar 7.1 KB2673771
# Bing Bar 7.1 KB2673770
# Bing Bar 7.0 KB2626808
# Bing Bar 7.0 KB2626806
# Bing Bar 7.0 KB2626807
# Bing Bar 7.0 KB2626804
# Bing Bar 7.0 KB2617376
# Skype for Windows desktop 7.3 (KB2876229) 
