xcopy /E /I /Y C:\Windows\SysWOW64\WindowsPowerShell\v1.0\Modules\PSWindowsUpdate C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSWindowsUpdate\
mkdir %CURRENTUSER%\Documents\WindowsPowerShell\Modules\PSWindowsUpdate
xcopy /E /I /Y C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PSWindowsUpdate %CURRENTUSER%\Documents\WindowsPowerShell\Modules\PSWindowsUpdate\

