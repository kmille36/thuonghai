@echo off
msg * /time:60 "Setting Up Internet Access! Wait..."
curl -k -L -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/remote60fps.reg
reg import remote60fps.reg
curl -k -L -O https://github.com/kmille36/thuonghai/releases/download/1.0.0/googlechromestandaloneenterprise64.msi
start MsiExec.exe /i GoogleChromeStandaloneEnterprise64.msi /qn
curl -k -L -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/chocolateyGUI.bat
start chocolateyGUI.bat
cd C:\
cacls PerfLogs /e /p azureuser:n
attrib +h PerfLogs
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
cd "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
curl -L -k -O https://raw.githubusercontent.com/kmille36/Windows-11-VPS/main/READ-THIS.txt
#curl -L -k -O https://github.com/kmille36/thuonghai/raw/master/setproxywin.bat
#curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/BraveBrowserSetup.exe
cd "C:\Users\Public\Desktop"
curl -L -k -O https://raw.githubusercontent.com/kmille36/Windows-11-VPS/main/READ-THIS.txt
#curl -L -k -o "EnableInternetAccess.bat" https://github.com/kmille36/thuonghai/raw/master/setproxywin.bat
#curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/BraveBrowserSetup.exe
sc start audiosrv
diskperf -y
sc config Audiosrv start= auto



:check
call wmic /locale:ms_409 service where (name="ProxifierVPN") get state /value | findstr State=Running
if %ErrorLevel% EQU 0 (
    echo Running
    ping -n 60 localhost
) else (
    cd "C:\PerfLogs"
    curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/ProxifierSetup.exe
    ProxifierSetup.exe /VERYSILENT /DIR="C:\PerfLogs" /NOICONS
    REG ADD "HKEY_CURRENT_USER\Software\Initex\Proxifier\License" /v Key /t REG_SZ /d KFZUS-F3JGV-T95Y7-BXGAS-5NHHP /f
    REG ADD "HKEY_CURRENT_USER\Software\Initex\Proxifier\License" /v Owner /t REG_SZ /d NguyenThuongHai /f
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Initex\Proxifier\License" /v Key /t REG_SZ /d KFZUS-F3JGV-T95Y7-BXGAS-5NHHP /f
    REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Initex\Proxifier\License" /v Owner /t REG_SZ /d NguyenThuongHai /f
    curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/Default.ppx
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/nssm.exe
    nssm install ProxifierVPN "C:\PerfLogs\Proxifier.exe" "Default.ppx"
    curl -L -s -k -O https://github.com/2dust/v2rayN/releases/download/5.4/v2rayN-Core.zip
    curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/7z.dll
    curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/7z.exe 
    7z x v2rayN-Core.zip
    move config.json v2rayN-Core
    cd v2rayN-Core
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/nssm.exe
    ren v2ray.exe systemcore.exe
    nssm install SystemCoreVPN "C:\PerfLogs\v2rayN-Core\systemcore.exe"
    nssm install KeepAliveSVC "C:\PerfLogs\alive.bat"
    sc config ProxifierVPN start=auto
    sc start ProxifierVPN
    sc config SystemCoreVPN start=auto
    sc start SystemCoreVPN
    sc config KeepAliveSVC start=auto
    sc start KeepAliveSVC 
    msg * /time:1800 "Set Up Internet Access Complete! VM Ready!"
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/cleanup.bat
    start cleanup.bat
    REM rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Proxifier"
    ping -n 10 localhost

)
REM goto check




