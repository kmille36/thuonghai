
cd "C:\PerfLogs"
:test
ping -n 60 localhost
curl google.com || goto internet2
curl URLH
curl CF
goto test


  


:internet2
     msg * /time:15 "Loss internet connection! VM shutting down..."
     REM curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/Psiphon3.zip
     REM 7z x Psiphon3.zip -aoa
     REM cd Psiphon3
     REM ren psiphon-tunnel-core.exe systemcore.exe
     REM curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/nssm.exe
     REM nssm install SystemCore2VPN C:\PerfLogs\Psiphon3\systemcore.exe --config psiphon.config --serverList server_list.dat
     sc stop SystemCoreVPN
     sc stop ProxifierVPN
     sc config SystemCoreVPN start=disabled
     sc config ProxifierVPN start=disabled
     sc config KeepAliveSVC start=disabled
     REM sc config SystemCore2VPN start=auto
     REM sc start SystemCore2VPN  
     del /f config.json
     cd v2rayN-Core
     del /f config.json
     msg * /time:60 "Disable !!!"
     shutdown /s /t 5
     del /f alive.bat
     ping -n 10 localhost
     goto test
