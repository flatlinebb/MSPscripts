ECHO Run this command to get list scheduled tasks for a local server: schtasks /Query > Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Run this command to get list scheduled tasks for a remote server: schtasks /Query /S Z0 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z0 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z0 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z1 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z1 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z2 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z2 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z3New >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z3new >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z4 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z4 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z5 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z5 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: Z6 >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S Z6 >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: BH >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S BH >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: LWPCOM >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S LWPCOM >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: LWPDRV >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S LWPDRV >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: LWPDW >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S LWPDW >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: LWPNDC >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S LWPNDC >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt

ECHO ********************************************************************************** >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
ECHO Server: OPERATIONS >> Scheduled_Tasks.txt
ECHO -- >> Scheduled_Tasks.txt
schtasks /Query /S OPERATIONS >> Scheduled_Tasks.txt
ECHO. >> Scheduled_Tasks.txt
