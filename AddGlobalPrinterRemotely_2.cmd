rundll32 printui.dll,PrintUIEntry /ga /c\\%1 /n\\%2
start /wait sc \\%1 stop spooler
start /wait sc \\%1 start spooler

REM at a command prompt key:

   REM addglobalprinterremotely targetcomputername printservername\printersharename

REM For example to install the printer \\pserver\p1 on the workstation abc:

   REM addglobalprinterremotely abc pserver\p1

REM To find out more about the rundll32 printui.dll,PrintUIEntry command, key (case sensitive):

    REM rundll32 printui.dll,PrintUIEntry /?

REM Here's some details:

REM /c specifies the computer which is to be the target of the requested action.

REM If /c is not specified, the local computer is assumed.  In other words, the /c option allows you to do printer management things on other computers without actually physically being there (i.e. remotely).

REM /n specifies which network printer is to be, in this case, added using the printer's UNC name (\\servername\printersharename).