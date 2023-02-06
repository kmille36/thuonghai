cd C:\Users\azureuser\AppData\Roaming\Microsoft\Windows\Themes
curl -k -L -O https://github.com/kmille36/thuonghai/raw/master/katacoda/AZ/dark-wallpaper.jpg
del /f TranscodedWallpaper
ren dark-wallpaper.jpg TranscodedWallpaper
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters ,1 ,True
tskill explorer
