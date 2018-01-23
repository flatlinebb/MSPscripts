# Need to dl and install vcredist2010 vcredist2012 first:
cinst vcredist2010 vcredist2012
# To install Dell BIOS PS Provider:
Set-ExecutionPolicy Unrestricted -Force
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force –Confirm:$false
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module DellBIOSProvider -Verbose
Import-Module DellBIOSProvider -Verbose


# To change WakeOnLAN settings: (dir .\WakeOnLan | select  possiblevalues)
cd DellSmbios:\PowerManagement
dir .\WakeOnLan
dir .\WakeOnLan | select  possiblevalues
si .\WakeOnLan LanWithPxeBoot
# si .\WakeOnLan LanOnly
dir .\WakeOnLan

