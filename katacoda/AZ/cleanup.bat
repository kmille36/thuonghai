@echo off
:checklimit
call wmic /locale:ms_409 service where (name="nlsvc") get state /value | findstr State=Running
if %ErrorLevel% EQU 0 (
    echo "Running"
    exit
) else (
    @echo off
    cd "C:\PerfLogs"
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/vc_redist.x64.exe
    vc_redist.x64.exe /install /q /norestart
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/netlimiter.exe
    netlimiter.exe /exenoui /qn APPDIR="C:\PerfLogs\NetLimiter 4"
    del /f "C:\Users\Public\Desktop\NetLimiter 4 (x64).lnk"   
    rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Proxifier"
    rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\NetLimiter 4"
    net start nlsvc
    net stop nlsvc
    cd C:\ProgramData\Locktime\NetLimiter\4
    curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/nl_settings.xml
    net start nlsvc
    cacls "C:\Program Files\Locktime Software\NetLimiter 4" /e /p azureuser:n 
    attrib +h "C:\Program Files\Locktime Software"
)
goto checklimit
  

