#!/bin/bash
stty intr ""
stty quit ""
stty susp undef








function goto
{
    label=$1
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

clear

echo "Script by fb.com/thuong.hai.581"
echo "Repo: https://github.com/kmille36/Windows-11-VPS"

goto step1
: step1
clear
echo "Script by fb.com/thuong.hai.581"
echo "Repo: https://github.com/kmille36/Windows-11-VPS"

echo "    _     ______   _ ____  _____ "
echo "   / \   |__  / | | |  _ \| ____|"
echo "  / _ \    / /| | | | |_) |  _|  "
echo " / ___ \  / /_| |_| |  _ <| |___ "
echo "/_/   \_\/____|\___/|_| \_\_____|"
echo    1.  HK -  East Asia
echo    2.  US -  East US
echo    3.  EU -  West Europe 
echo    4.  JP -  Japan East
echo    5.  AU -  Australia
echo    6.  KR -  Korea South
read -p "Please select your Azure VM region (type number then press enter):" ans
case $ans in
    1  )  echo "HK"; echo eastasia > vm  ;;
    2  )  echo "US"; echo eastus > vm  ;;
    3  )  echo "EU"; echo westeurope > vm  ;;
    4  )  echo "JP"; echo japaneast > vm  ;;
    5  )  echo "AU"; echo australiasoutheast > vm  ;;
    6  )  echo "KR"; echo koreasouth > vm  ;;
    ""     )  echo "Empty choice!!!"; sleep 1; goto step1 ;;
    *      )  echo "Invalid choice!!!"; sleep 1 ; goto step1 ;;
esac


goto step2
: step2
clear
echo "Script by fb.com/thuong.hai.581"
echo "Repo: https://github.com/kmille36/Windows-11-VPS"

echo "    _     ______   _ ____  _____ "
echo "   / \   |__  / | | |  _ \| ____|"
echo "  / _ \    / /| | | | |_) |  _|  "
echo " / ___ \  / /_| |_| |  _ <| |___ "
echo "/_/   \_\/____|\___/|_| \_\_____|"
echo "1. Windows Server 2022 + VS Code + VS Studio"
echo "2. Windows 10 Enterprise + MS365 APP"
echo "3. Windows 11 Enterprise + MS365 APP"
echo "4. Windows 11 Azure Virtual Desktop"
echo "5. Windows 10 Azure Virtual Desktop"
echo "6. Windows 10 Pro (User Request)"
echo "7. Windows 11 Pro (User Request)"
echo "8. [NEW] Windows 11 Pro Insider Preview"
echo "9. [NEW] Windows 11 AVD Insider Preview"
read -p "Please select your Azure VM windows (type number then press enter):" ans
case $ans in
    1  )  echo "Windows Server 2022 + VS Code + VS Studio" > abc; echo MicrosoftVisualStudio:visualstudio2022:vs-2022-comm-latest-ws2022:2022.09.21 > win  ;;
    2  )  echo "Windows 10 Enterprise + MS365 APP" > abc; echo MicrosoftWindowsDesktop:windows-ent-cpc:win10-21h2-ent-cpc-m365:19044.1889.220810 > win  ;;
    3  )  echo "Windows 11 Enterprise + MS365 APP" > abc; echo MicrosoftWindowsDesktop:windows-ent-cpc:win11-21h2-ent-cpc-m365:22000.856.220810 > win  ;;
    4  )  echo "Windows 11 Azure Virtual Desktop" > abc; echo MicrosoftWindowsDesktop:windows-11:win11-21h2-avd:22000.978.220910 > win  ;;
    5  )  echo "Windows 10 Azure Virtual Desktop" > abc; echo MicrosoftWindowsDesktop:Windows-10:win10-21h2-avd:19044.2130.221006 > win  ;;
    6  )  echo "Windows 10 Pro" > abc; echo MicrosoftWindowsDesktop:Windows-10:win10-21h2-pro:19044.2130.221006 > win  ;;
    7  )  echo "Windows 11 Pro" > abc; echo MicrosoftWindowsDesktop:windows-11:win11-21h2-pro:22000.978.220910 > win  ;;
    8  )  echo "Windows 11 Pro Insider Preview" > abc; echo MicrosoftWindowsDesktop:windows11preview:win11-22h2-pro:22621.521.220910 > win  ;;
    9  )  echo "Windows 11 Azure Virtual Desktop Insider Preview" > abc; echo MicrosoftWindowsDesktop:windows11preview:win11-22h2-avd:22621.521.220910 > win  ;;
    ""     )  echo "Empty choice!!!"; sleep 1; goto step2 ;;
    *      )  echo "Invalid choice!!!"; sleep 1 ; goto step2 ;;
esac


goto step3
: step3
clear
echo "Script by fb.com/thuong.hai.581"
echo "Repo: https://github.com/kmille36/Windows-11-VPS"

echo "    _     ______   _ ____  _____ "
echo "   / \   |__  / | | |  _ \| ____|"
echo "  / _ \    / /| | | | |_) |  _|  "
echo " / ___ \  / /_| |_| |  _ <| |___ "
echo "/_/   \_\/____|\___/|_| \_\_____|"
echo "1. Standard_DS2_v2 - 2CPU/7GB - Suitable if you want VM with the highest performance"
echo "2. Standard_B2ms - 2CPU/8GB - Suitable if you want VM with the highest performance and more ram"
echo "3. Standard_D2s_v3 - 2CPU/8GB - Slower than DS2_v2 and B2ms but have nested virtualization"
read -p "Please select your Azure VM size (type number then press enter):" ans
case $ans in
    1  )  echo "OK"; echo "Standard_DS2_v2" > size ;;
    2  )  echo "OK"; echo "Standard_B2ms" > size ;;
    3  )  echo "OK"; echo "Standard_D2s_v3" > size  ;;
    ""     )  echo "Empty choice!!!"; sleep 1; goto step3 ;;
    *      )  echo "Invalid choice!!!"; sleep 1 ; goto step3 ;;
esac

goto begin
: begin
echo "⌛  Setting up... Please Wait..."

az group list | jq -r '.[0].name' > rs
rs=$(cat rs) 

az webapp list --resource-group $rs --output table |  grep -q haivm && goto checkwebapp

echo $RANDOM$RANDOM > number
NUMBER=$(cat number)
echo "haivm$NUMBER$NUMBER.azurewebsites.net/metrics" > site

location=$(cat vm)
echo "az appservice plan create --name myAppServicePlan$NUMBER$NUMBER --resource-group $rs --location $location --sku F1 --is-linux --output none && az webapp create --resource-group $rs --plan myAppServicePlan$NUMBER$NUMBER --name haivm$NUMBER$NUMBER --deployment-container-image-name docker.io/thuonghai2711/v2ray-azure-web:latest --output none" > webapp.sh 
nohup bash webapp.sh  &>/dev/null &

goto checkvm
: checkvm
echo "⌛  Checking Previous VM..."
az vm list-ip-addresses -n Windows-VM-PLUS --output tsv > IP.txt 
[ -s IP.txt ] && bash -c "echo You Already Have Running VM... && az vm list-ip-addresses -n Windows-VM-PLUS --output table" && goto ask

echo "🖥️  Creating In Process..."
location=$(cat vm)
image=$(cat win)
size=$(cat size)
rs=$(cat rs) && az vm create --resource-group $rs --name Windows-VM-PLUS --image $image --public-ip-sku Standard --size $size --location $location --admin-username azureuser --admin-password WindowsPassword@001 --nic-delete-option delete --os-disk-delete-option delete --out table


: test
echo "⌛  Wait... (Can take up to 2 minutes)"
URL=$(cat site)
CF=$(curl -s --connect-timeout 5 --max-time 5 $URL | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | sed s/'http[s]\?:\/\/'//)
echo -n $CF > CF
cat CF | grep trycloudflare.com > CF2
if [ -s CF2 ]; then goto rdp; else goto webapp; fi

: webapp
rs=$(cat rs) 
NUMBER=$(cat number)
#az webapp config appsettings set --resource-group $rs --name haivm$NUMBER$NUMBER --settings WEBSITES_PORT=8081 --output none
goto pingcf

: pingcf
URL=$(cat site)
CF=$(curl -s --connect-timeout 5 --max-time 5 $URL | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | sed s/'http[s]\?:\/\/'//)
echo -n $CF > CF
cat CF | grep trycloudflare.com > CF2
if [ -s CF2 ]; then goto rdp; else echo -en "\r Checking .     $i 🌐 ";sleep 0.1;echo -en "\r Checking ..    $i 🌐 ";sleep 0.1;echo -en "\r Checking ...   $i 🌐 ";sleep 0.1;echo -en "\r Checking ....  $i 🌐 ";sleep 0.1;echo -en "\r Checking ..... $i 🌐 ";sleep 0.1;echo -en "\r Checking     . $i 🌐 ";sleep 0.1;echo -en "\r Checking  .... $i 🌐 ";sleep 0.1;echo -en "\r Checking   ... $i 🌐 ";sleep 0.1;echo -en "\r Checking    .. $i 🌐 ";sleep 0.1;echo -en "\r Checking     . $i 🌐 ";sleep 0.1 && goto pingcf; fi


goto rdp
: rdp

rs=$(cat rs)

echo "Open all ports on a VM to inbound traffic"
az vm open-port --resource-group $rs --name Windows-VM-PLUS --port '*' --output none

echo " Done! "
IP=$(az vm show -d -g $rs -n Windows-VM-PLUS --query publicIps -o tsv)
echo "Public IP: $IP"
echo "Username: azureuser"
echo "Password: WindowsPassword@001"

echo "🖥️  Run Command Setup Internet In Process... (10s)"

goto laststep
: laststep
URL=$(cat site)
CF=$(curl -s --connect-timeout 5 --max-time 5 $URL | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | sed s/'http[s]\?:\/\/'//)
echo -n $CF > CF
cat CF | grep trycloudflare.com > CF2
if [ -s CF2 ]; then echo OK; else echo -en "\r Checking .     $i 🌐 ";sleep 0.1;echo -en "\r Checking ..    $i 🌐 ";sleep 0.1;echo -en "\r Checking ...   $i 🌐 ";sleep 0.1;echo -en "\r Checking ....  $i 🌐 ";sleep 0.1;echo -en "\r Checking ..... $i 🌐 ";sleep 0.1;echo -en "\r Checking     . $i 🌐 ";sleep 0.1;echo -en "\r Checking  .... $i 🌐 ";sleep 0.1;echo -en "\r Checking   ... $i 🌐 ";sleep 0.1;echo -en "\r Checking    .. $i 🌐 ";sleep 0.1;echo -en "\r Checking     . $i 🌐 ";sleep 0.1 && goto laststep; fi
#seq 1 100 | while read i; do echo -en "\r Running .     $i %";sleep 0.1;echo -en "\r Running ..    $i %";sleep 0.1;echo -en "\r Running ...   $i %";sleep 0.1;echo -en "\r Running ....  $i %";sleep 0.1;echo -en "\r Running ..... $i %";sleep 0.1;echo -en "\r Running     . $i %";sleep 0.1;echo -en "\r Running  .... $i %";sleep 0.1;echo -en "\r Running   ... $i %";sleep 0.1;echo -en "\r Running    .. $i %";sleep 0.1;echo -en "\r Running     . $i %";sleep 0.1; done
URL=$(cat site)
CF=$(curl -s $URL | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u | sed s/'http[s]\?:\/\/'//) && echo $CF > CF
rs=$(cat rs)


timeout 10s az vm run-command invoke  --command-id RunPowerShellScript --name Windows-VM-PLUS -g $rs --scripts "cd C:\PerfLogs ; cmd /c curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/alive.bat ; (gc alive.bat) -replace 'URLH', '$URL' | Out-File -encoding ASCII alive.bat ; (gc alive.bat) -replace 'CF', '$CF' | Out-File -encoding ASCII alive.bat ; cmd /c curl -L -s -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/config.json ; (gc config.json) -replace 'CF', '$CF' | Out-File -encoding ASCII config.json ; cmd /c curl -L -k -O https://raw.githubusercontent.com/kmille36/thuonghai/master/katacoda/AZ/internet.bat ; cmd /c internet.bat" --out table



rm -rf vm
rm -rf CF 
rm -rf CF2
rm -rf IP.txt
rm -rf rs
rm -rf webapp.sh
rm -rf number
rm -rf site

NAME=$(cat abc)
echo "Your $NAME is READY TO USE !!! "

sleep 7200

: checkwebapp
rs=$(cat rs)
web=$(az webapp list --query "[].{hostName: defaultHostName, state: state}" --output tsv | grep haivm | cut -f 1)
echo $web/metrics > site
goto checkvm

#&& az webapp config appsettings set --resource-group $rs --name haivm$NUMBER$NUMBER --settings WEBSITES_PORT=8081 --output none

#&& az webapp config appsettings set --resource-group $rs --name haivm$NUMBER$NUMBER --settings WEBSITES_PORT=8081 --output none

: ask
      echo "       Do you want to keep current VM?"
      echo "y: Keep current VM states and output RDP File"
      echo "n: Delete previous VM then re-create new one"
while true
do 
      read -r -p "Press [y/n] then enter: " input
 
      case $input in
            [yY][eE][sS]|[yY])
                  goto test
                  break
                  ;;
            [nN][oO]|[nN])
                  echo "🖥️  Deleting VM... (about 3m)"
                  rs=$(cat rs) 
                  #az vm delete --ids $(az vm list -g $rs --query "[].id" -o tsv) --yes
                  app=$(az appservice plan list --query "[].name" -o tsv)
                  web=$(az webapp list --query "[].repositorySiteName" --output tsv)
                  az webapp delete --name $web --resource-group $rs 2>nul
                  az appservice plan delete --name $app --resource-group $rs --yes 2>nul
                  RESOURCE_GROUP=$rs
                  VM_NAME=Windows-VM-PLUS

                  INTERFACE_ID=$(az vm show --resource-group ${RESOURCE_GROUP} --name ${VM_NAME} --query networkProfile.networkInterfaces[0].id)
                  INTERFACE_ID=${INTERFACE_ID:1: -1}
                  OS_DISK_ID=$(az vm show --resource-group ${RESOURCE_GROUP} --name ${VM_NAME} --query storageProfile.osDisk.managedDisk.id)
                  OS_DISK_ID=${OS_DISK_ID:1: -1}
                  SECURITY_GROUP_ID=$(az network nic show --id ${INTERFACE_ID} --query networkSecurityGroup.id)
                  SECURITY_GROUP_ID=${SECURITY_GROUP_ID:1: -1}
                  PUBLIC_IP_ID=$(az network nic show --id ${INTERFACE_ID} --query ipConfigurations[0].publicIpAddress.id)
                  PUBLIC_IP_ID=${PUBLIC_IP_ID:1: -1}
                  az vm delete --resource-group ${RESOURCE_GROUP} --name ${VM_NAME} --yes
                  az network nic delete --id ${INTERFACE_ID}
                  az disk delete --id ${OS_DISK_ID} --yes
                  az network nsg delete --id ${SECURITY_GROUP_ID}
                  az network public-ip delete --id ${PUBLIC_IP_ID}
                  az network vnet delete -g ${RESOURCE_GROUP} -n ${VM_NAME}VNET
                  
                  deleteUnattachedNics=1

                  unattachedNicsIds=$(az network nic list --query '[?virtualMachine==`null`].[id]' -o tsv)
                  for id in ${unattachedNicsIds[@]}
                  do
                  if (( $deleteUnattachedNics == 1 ))
                  then

                  echo "Deleting unattached NIC with Id: "$id
                  az network nic delete --ids $id
                  echo "Deleted unattached NIC with Id: "$id
                  else
                  echo $id
                  fi
                  done
                  echo "Cleaning...(50s)"
                  sleep 50

                  goto begin
                  break
                  ;;
            *)
                  echo "Invalid input..."
                  ;;
      esac      
done
