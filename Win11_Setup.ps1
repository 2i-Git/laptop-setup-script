powershell Set-ExecutionPolicy RemoteSigned

$confirmInput = Read-Host "The installation process will take some time to complete. Ensure that laptop is connected to mains power. Press any key followed by enter to continue"

Write-Host "Package Installations"
# Install Chocolatey
choco install chocolatey-core.extension
choco install chocolatey-dotnetfx.extension
choco install chocolatey-fastanswers.extension
choco install chocolatey-dotnetfx.extension
choco install chocolatey-visualstudio.extension
choco install chocolatey-windowsupdate.extension
choco install chocolateygui -y
# Install Windows Tools
choco install vcredist-all -y
choco install dotnet-runtime -y
choco install dotnetfx -y
choco install wget -y
wsl --install
choco install wsl-ubuntu-2004 -y
choco install openssh -y
choco install powertoys -y
# Install Desktop Applications
choco install 7zip -y
choco install adobereader -y
choco install audacity -y
choco install audacity-lame -y
choco install blender -y
choco install calibre -y
choco install coretemp -y
choco install gimp -y
choco install handbrake.install -y
choco install irfanview -y
choco install obs-studio -y
choco install oldcalc -y
choco install openvpn -y
choco install paint.net -y
choco install slack -y
choco install vlc -y
choco install zoom -y
choco install jcpicker -y
# Install Browsers
choco install brave -y
choco install chromium -y
choco install firefox -y
choco install googlechrome -y
# Install GIT
choco install git -y
choco install github-desktop -y
# Install Language Tooling (Java at Version 20)
choco install openjdk -y
choco install maven -y
choco install ant -y
choco install gradle -y
choco install nodejs.install -y
choco install ruby -y
choco install php -y
choco install python3 -y
# Install IDEs
choco install intellijidea-community -y
choco install notepadplusplus -y
choco install pycharm-community -y
choco install vscode -y
choco install vim -y
choco install visualstudio2019community -y
# Install Network Tools
choco install curl -y
choco install wget -y
choco install filezilla -y
choco install mremoteng -y
choco install postman -y
choco install putty.install -y
choco install realvnc -y
choco install vnc-viewer -y
choco install wireshark -y
# Install Automation Tools
choco install chromedriver -y
choco install cypress -y
choco install selenium -y
choco install jenkins -y
# Install Docker
choco install docker-desktop -y
# Install Database Tooling
choco install mysql -y
choco install mysql.workbench -y
choco install mongodb -y
choco install mongodb-shell -y


# Update Packages
choco upgrade all -y

Write-Host "Setting Update Packages On Restart"
# Create Scheduled Task To Update Packages
$Trigger = New-ScheduledTaskTrigger -AtStartup
$Principal = New-ScheduledTaskPrincipal -UserID "$env:USERDOMAIN\$env:USERNAME" -RunLevel Highest
$Action = New-ScheduledTaskAction -Execute 'Powershell.exe' `
    -Argument 'choco upgrade all'
Register-ScheduledTask -TaskName "Choco Upgrade All" -Description "Update Chocolatey Packages On Startup" -Action $Action -Trigger $Trigger -Principal $Principal -Force
