@echo off 
rem -----------------------------------------------------------------------------------------------------
rem - Logmein Rescue Sample Scripts 
rem - Template which determines OS Type 
rem - 
rem - This template script can be used to execute the appropriate command for the
rem - appropriate version of windows. The original code came from the site: 
rem - http://malektips.com/xp_dos_0025.html 
rem - 
rem - Script last updated in August 2010. Will require updating with new releases
rem - of windows. 
rem -----------------------------------------------------------------------------------------------------
echo EXECUTINGSCRIPT(%0) 
echo Starting DOS Script. Detecting Version of Windows 

ver | find "6.1" > nul 
if %ERRORLEVEL% == 0 goto ver_61 

ver | find "6.0" > nul 
if %ERRORLEVEL% == 0 goto ver_60 

ver | find "5.2" > nul 
if %ERRORLEVEL% == 0 goto ver_52 

ver | find "XP" > nul 
if %ERRORLEVEL% == 0 goto ver_xp 

ver | find "2000" > nul 
if %ERRORLEVEL% == 0 goto ver_2000 

ver | find "NT" > nul 
if %ERRORLEVEL% == 0 goto ver_nt 

goto warnthenexit 

rem -----------------------------------------------------------------------------------------------------
rem - Modify commands below for the appropriate operating system 
rem -----------------------------------------------------------------------------------------------------
 
:ver_61 
rem - Run Windows 7 or Windows Server 2008 R2 specific commands here. 
echo Windows 7 or Windows Server 2008 R2 (ver 6.1) Detected by script 
netsh advfirewall set profiles AllProfiles off 
goto exit 

:ver_60 
rem - Run Windows Vista or Windows Server 2008 R1 specific commands here. 
echo Windows Vista or Windows Server 2008 R1(ver 6.0) Detected by script 
netsh advfirewall set profiles AllProfiles off 
goto exit 

:ver_xp 
rem - Run Windows XP 32-bit specific commands here. 
echo Windows XP 32-bit Detected by script 
netsh firewall set opmode disable 
goto exit 

:ver_52 
rem - Run Windows Server 2003 or Windows XP 64-bit specific commands here. 
echo Windows Server 2003 or Windows XP 64-bit Detected by script 
echo No scripting logic available for this Windows Version 
goto exit 

:ver_2000 
rem - Run Windows 2000 specific commands here. 
echo Windows 2000 Detected by script 
echo No scripting logic available for this Windows Version 
goto exit 

:ver_nt 
rem - Run Windows NT specific commands here. 
echo Windows NT Detected by script 
echo No scripting logic available for this Windows Version 
goto exit 

:warnthenexit 
echo ERROR: Windows version NOT detected! Perhaps this script needs updating. Exiting now!
 ver 

:exit 
echo DOS Script Exiting! 

rem -----------------------------------------------------------------------------------------------------
rem - Copyright (C) 2003-2010 LogMeIn, Inc. US patents pending. - 
rem - This script can be re-distributed for demonstration purposes only. - 
rem - Use of this script is subject to general Logmein Terms and Conditions found here: -
rem - https://secure.logmein.com/termsandconditions.asp - 
rem ----------------------------------------------------------------------------------------------------- 