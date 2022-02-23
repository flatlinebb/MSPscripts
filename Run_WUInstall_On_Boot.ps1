##
# PowerShell module 'PSWindowsUpdate' must be installed on the system for this script to work!
##
#
##
# To install the module, please run the commands below:
#      [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
#      Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Confirm:$false -ErrorAction SilentlyContinue
#      Register-PSRepository -Default -ErrorAction SilentlyContinue
#      Set-PSRepository -Name PSGallery -InstallationPolicy Trusted -ErrorAction SilentlyContinue
#      Set-ExecutionPolicy RemoteSigned -Force
#      Install-Module PSWindowsUpdate -Confirm:$false -ErrorAction SilentlyContinue
#      Import-Module PSWindowsUpdate -ErrorAction SilentlyContinue
##
# Put this command in a shortut in "shell:StartUp" (C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup) so it runs on Windows start up
#    C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -NonInteractive -NoProfile -ExecutionPolicy Bypass -Command "C:\Support\Run_WUInstall_On_Boot.ps1"
#    Start in: C:\Support
##
# Or run from a separate batch file located in the same folder as the PS script:
#    @ECHO OFF
#    powershell.exe -NoLogo -NonInteractive -NoProfile "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -NoLogo -NonInteractive -NoProfile -File "%~dp0Run_WUInstall_On_Boot.ps1"' -Verb RunAs"
#    exit
##

param ( $Show )
if ( !$Show ) 
{
    PowerShell -NoLogo -NonInteractive -NoProfile -NoExit -File $MyInvocation.MyCommand.Path 1
    return
}

Write-Host "Starting Windows Update process. Please wait for it to complete ..."

Write-Host "Hiding junk updates for Bing and Skype ..."
Hide-WindowsUpdate -Title "Bing*,Skype*" -MicrosoftUpdate -Confirm:$false

# This mostly applies to Windows 7
# Only included here as a sample on how to hide specific KB's:
# Write-Host "Hiding MS Essentials updates: KB3140479,KB2902907,KB2876229  ...."
# Hide-WindowsUpdate -KBArticleID "KB2876229,KB2673774,KB2673773,KB2673772,KB2673771,KB2673770,KB2626808,KB2626806,KB2626807,KB2626804,KB2617376" -MicrosoftUpdate -Confirm:$false

Write-Host "Registering Microsoft Update Service ..."
Add-WUServiceManager -ServiceID "7971f918-a847-4430-9279-4a52d1efe18d" -Confirm:$false

Write-Host "Starting Updates Install ..."
Install-WindowsUpdate -MicrosoftUpdate -RecurseCycle 3 -AcceptAll -AutoReboot -Confirm:$false

# -RecurseCycle 3 = runs the update cycle 3 times if a reboot is needed and there are more updates to be installed after a reboot. 
#                   Eliminates the need to create a shortcut in the StartUp folder.
# -RecurseCycle <int>
#        Specify number of cycles for check updates after successful update installation or system startup. First run is always main cycle (-RecurseCycle 1
#        or none). Second (-RecurseCycle 2) and n (-RecurseCycle n) cycle are recursive.
###
# This mostly applies to Windows 7
# Microsoft Security Essentials KB3140479
# Microsoft Security Essentials KB2902907
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
