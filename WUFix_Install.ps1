Invoke-WebRequest 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2015/04/windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu' -OutFile 'windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu'
wusa.exe windows6.1-kb3020369-x64_5393066469758e619f21731fc31ff2d109595445.msu /quiet /norestart

Invoke-WebRequest 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/02/windows6.1-kb3138612-x64_f7b1de8ea7cf8faf57b0138c4068d2e899e2b266.msu' -OutFile 'windows6.1-kb3138612-x64_f7b1de8ea7cf8faf57b0138c4068d2e899e2b266.msu'
wusa.exe windows6.1-kb3138612-x64_f7b1de8ea7cf8faf57b0138c4068d2e899e2b266.msu /quiet /norestart

Invoke-WebRequest 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2016/04/windows6.1-kb3145739-x64_b9ae7ee29555dce4d1a225fd1324176a2538178a.msu' -OutFile 'windows6.1-kb3145739-x64_b9ae7ee29555dce4d1a225fd1324176a2538178a.msu'
wusa.exe windows6.1-kb3145739-x64_b9ae7ee29555dce4d1a225fd1324176a2538178a.msu /quiet /norestart

Invoke-WebRequest 'http://download.windowsupdate.com/d/msdownload/update/software/updt/2016/09/windows6.1-kb3172605-x64_2bb9bc55f347eee34b1454b50c436eb6fd9301fc.msu' -OutFile 'windows6.1-kb3172605-x64_2bb9bc55f347eee34b1454b50c436eb6fd9301fc.msu'
wusa.exe windows6.1-kb3172605-x64_2bb9bc55f347eee34b1454b50c436eb6fd9301fc.msu /quiet /norestart

Invoke-WebRequest 'http://download.windowsupdate.com/windowsupdate/redist/standalone/7.6.7600.320/WindowsUpdateAgent-7.6-x64.exe' -OutFile 'WindowsUpdateAgent-7.6-x64.exe'
WindowsUpdateAgent-7.6-x64.exe /quiet /norestart /wuforce
