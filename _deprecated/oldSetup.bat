@ECHO OFF

:raiseAdministrator
    IF exist "%SystemRoot%\SysWOW64" PATH %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
        bcdedit >nul
    IF '%errorlevel%' NEQ '0' (
        GOTO UACPrompt
    )
    ELSE (
        GOTO UACAdmin
    )
    :UACPrompt
        %1 START "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
        EXIT /B
    :UACAdmin
        cd /d "%~dp0"
        The current running PATH of ECHO is% CD%
        ECHO has obtained administrator rights

:informationPrompt
    CLS
    ECHO:
    ECHO Welcome to 2i Engineering Laptop Setup Script v1.01
    ECHO:
    ECHO This script is designed to automate the software setup for your Windows machine.
    ECHO The installation packages are:
    ECHO:
    ECHO        MICROSOFT PREREQUISATES
    ECHO        .NET, C++ Runtimes, Windows Subsystem for Linux
    ECHO:
    ECHO        DESKTOP APPLICATIONS:
    ECHO        Chrome, Firefox, Teams, 7Zip, Paint.net, Acrobat, Audacity, VLC, Handbrake, OBS, Calibre
    ECHO:
    ECHO        NETWORK TOOLS:
    ECHO        Putty, MremoteNG, Filezilla, Wireshark, cURL, GNU Wget, VNC Viewer
    ECHO:
    ECHO        DEVELOPMENT PREREQUISATES:
    ECHO        JRE8, JDK8, MAVEN, Python3, Node.JS
    ECHO:
    ECHO        DEVELOPMENT TOOLS:
    ECHO        Notepad++, VSCode, IntelliJ IDEA, GIT, Postman, Docker
    ECHO:
    ECHO        AUTOMATION TOOLS:
    ECHO        Jenkins, Cypress, Selenium, Chromedriver
    ECHO:
    ECHO:
    CHOICE /m "Continue To Installation Options?"
    GOTO mainInstallOption%ERRORLEVEL%



:mainInstallOption1
    CLS
    ECHO:
    ECHO 1. Check Required Privilages.
    ECHO 2. Install Package Manager.
    ECHO 3. Enable Auto-update.
    ECHO 4. Disable Auto-update.
    ECHO 5. Install All Packages.     [AUTOMATIC]
    ECHO 6. Install Packages.         [MANUAL CONTROL]
    ECHO 7. Remove All Packages.      [AUTOMATIC]
    ECHO 8. Restart Computer.
    ECHO 9. Quit.
    ECHO:
    CHOICE /c 123456789 /n /m "Please Select Option."
    GOTO InstallOption%ERRORLEVEL%

:mainInstallOption2
    GOTO installOption9

:installOption1
    CLS
    ECHO:
    ECHO Administrative permissions required. Detecting permissions...
    ECHO:
    ECHO:
    net session >nul 2>&1
    if %errorLevel% == 0 (
        ECHO SUCCESS:
        ECHO        Administrative permissions confirmed.
        ECHO:
        ECHO:
        PAUSE
        GOTO mainInstallOption1
    ) else (
        ECHO FAILURE:
        ECHO        Permissions inadequate for installation.
        ECHO:
        ECHO:
        PAUSE
        GOTO installOption9
    )
:installOption2
    CLS
    ECHO:
    ECHO Installing Chocolately...
    ECHO:
    ECHO:
    @REM This installs chocolately, adds choco to PATH, and adds the choco extensions
    @POWERSHELL -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
    choco install chocolatey-core.extension
    choco install chocolatey-dotnetfx.extension
    choco install chocolatey-fastanswers.extension
    PAUSE
    GOTO :mainInstallOption1

:installOption3
    CLS
    ECHO:
    ECHO Enabling Automatic Package Updates...
    ECHO:
    ECHO:
    @REM This installs the automatic package update package
    choco install choco-upgrade-all-at-startup -y
    PAUSE
    GOTO :mainInstallOption1

:installOption4
    CLS
    ECHO:
    ECHO Disabling Automatic Package Updates...
    ECHO:
    ECHO:
    @REM This uninstalls the automatic package update package
    choco uninstall choco-upgrade-all-at-startup -y
    PAUSE
    GOTO :mainInstallOption1

:installOption5
    CLS
    @REM Automatically installs all packages.
    ECHO:
    ECHO All packages will be automatically installed.
    ECHO Your system will automatically restart.
    ECHO Please save all current work.
    ECHO Please close all open applications.
    ECHO:
    PAUSE
    CLS
    ECHO:
    ECHO Beginning automatic installation of all packages.
    ECHO:
    ECHO:
    @REM Install MS Prerequisates
    choco install vcredist-all -y
    choco install dotnet-runtime -y
    choco install dotnetfx -y
    wsl --install
    choco install wget -y
    @REM Install Desktop Applications
    choco install adobereader -y
    choco install 7zip -y
    choco install paint.net -y
    choco install audacity -y
    choco install audacity-lame -y
    choco install googlechrome -y
    choco install firefox -y
    choco install microsoft-teams.install -y
    choco install obs-studio -y
    choco install handbrake.install -y
    choco install vlc -y
    choco install calibre -y
    @REM Install Language Tools
    choco install jre8 -y
    choco install jdk8 -y
    choco install maven -y
    choco install python3 -y
    choco install nodejs.install -y
    choco install git.install -y
    @REM Install IDEs
    choco install notepadplusplus.install -y
    choco install vscode -y
    choco install intellijidea-community -y
    @REM Install Network Tools
    choco install putty.install -y
    choco install mremoteng -y
    choco install filezilla -y
    choco install curl -y
    choco install wireshark -y
    choco install postman -y
    choco install vnc-viewer -y
    @REM Install Automation tools
    choco install jenkins -y
    choco install selenium -y
    choco install cypress -y
    choco install chromedriver -y
    @REM Install Docker
    choco install docker-desktop -y
    ECHO:
    GOTO restartChoice1
    @REM if any abort auto reboot, return to main menu...
    GOTO :mainInstallOption1

@REM-------------------------------------------------
@REM ----------manual package script begins----------
@REM-------------------------------------------------

:installOption6
    CLS
    @REM Manually control package installations.
    ECHO:
    ECHO Beginning controlled installation of all packages...
    ECHO:
    ECHO:
    @REM Installs Microsoft Prerequisates
    ECHO:
    GOTO manualInstallBegin

    :manualInstallBegin
        ECHO:
        CHOICE /m "Install Microsoft Visual Studio C++ Runtimes?"
        GOTO installVcredist%errorLevel%
    :installVcredist1
        choco install vcredist140

    :installVcredist2
        ECHO:
        CHOICE /m "Install Microsoft .NET Runtimes?"
        GOTO installMSDotNet$errorLevel%
    :installMSDotNet1
        choco install dotnet-runtime
        choco install dotnetfx

    :installMSDotNet2
        ECHO:
        CHOICE /m "Install Windows Subsystem for Linux?"
        GOTO installWSL%errorLevel%
    :installWSL1
        wsl --install

    :installWSL2
        ECHO:
        CHOICE /m "Install GNU Wget?"
        GOTO installGnuWget%errorLevel%
    :installGnuWget1
        choco install wget

    :installGnuWget2
        @REM Installs Desktop Applications
        ECHO:
        CHOICE /m "Install Adobe Acrobat Reader?"
        GOTO installAcrobat%errorLevel%
    :installAcrobat1
        choco install adobereader

    :installAcrobat2
        ECHO:
        CHOICE /m "Install 7Zip Archiver?"
        GOTO install7Zip%errorLevel%
    :install7Zip1
        choco install 7zip

    :install7Zip2
        ECHO:
        CHOICE /m "Install Paint.net?"
        GOTO installPaintDotNet%errorLevel%
    :installPaintDotNet1
        choco install paint.net

    :installPaintDotNet2
        ECHO:
        CHOICE /m "Install Audacity & LAME?"
        GOTO installAudacity%errorLevel%
    :installAudacity1
        choco install audacity
        choco install audacity-lame

    :installAudacity2
        ECHO:
        CHOICE /m "Install Google Chrome?"
        GOTO installChrome%errorLevel%
    :installChrome1
        choco install googlechrome

    :installChrome2
        ECHO:
        CHOICE /m "Install Mozilla Firefox?"
        GOTO installFirefox%errorLevel%
    :installFirefox1
        choco install firefox

    :installFirefox2
        ECHO:
        CHOICE /m "Install Microsoft Teams?"
        GOTO installTeams%errorLevel%
    :installTeams1
        choco install microsoft-teams.install

    :installTeams2
        ECHO:
        CHOICE /m "Install OBS Studio?"
        GOTO installObsStudio%errorLevel%
    :installObsStudio1
        choco install obs-studio

    :installObsStudio2
        ECHO:
        CHOICE /m "Install Handbrake?"
        GOTO installHandbrake%errorLevel%
    :installHandbrake1
        choco install handbrake.install

    :installHandbrake2
        ECHO:
        CHOICE /m "Install VLC Media Player?"
        GOTO installVLC%errorLevel%
    :installVLC1
        choco install vlc

    :installVLC2
        ECHO:
        CHOICE /m "Install Calibre Ebook Reader?"
        GOTO installCalibre%errorLevel%
    :installCalibre1
        choco install calibre

    :installCalibre2
        ECHO:
        @REM Installs Language Tools
        CHOICE /m "Install Java Runtime Environment 8?"
        GOTO installJRE%errorLevel%
    :installJRE1
        choco install jre8

    :installJRE2
        ECHO:
        CHOICE /m "Install Java Development Kit 8?"
        GOTO installJDK%errorLevel%
    :installJDK1
        choco install jdk8

    :installJDK2
        ECHO:
        CHOICE /m "Install MAVEN?"
        GOTO installMaven%errorLevel%
    :installMaven1
        choco install maven

    :installMaven2
        ECHO:
        CHOICE /m "Install Python 3?"
        GOTO installPython%errorLevel%
    :installPython1
        choco install python3

    :installPython2
        ECHO:
        CHOICE /m "Install Node.JS?"
        GOTO installNode%errorLevel%
    :installNode1
        choco install nodejs.install

    :installNode2
        ECHO:
        CHOICE /m "Install GIT?"
        GOTO installGit%errorLevel%
    :installGit1
        choco install git.install

    :installGit2
        ECHO:
        @REM Installs IDEs
        CHOICE /m "Install Notepad++?"
        GOTO installNotepadPlusPlus%errorLevel%
    :installNotepadPlusPlus1
        choco install notepadplusplus.install

    :installNotepadPlusPlus2
        ECHO:
        CHOICE /m "Install VSCode?"
        GOTO installVscode%errorLevel%
    :installVscode1
        choco install vscode

    :installVscode2
        ECHO:
        CHOICE /m "Install IntelliJ IDEA?"
        GOTO installIdea%errorLevel%
    :installIdea1
        choco install intellijidea-community

    :installIdea2
        ECHO:
        @REM Installs Network Tools
        CHOICE /m "Install Putty?"
        GOTO installPutty%errorLevel%
    :installPutty1
        choco install putty.install

    :installPutty2
        ECHO:
        CHOICE /m "Install MremoteNG?"
        GOTO installMremoteng%errorLevel%
    :installMremoteng1
        choco install mremoteng

    :installMremoteng2
        ECHO:
        CHOICE /m "Install Filezilla?"
        GOTO installFilezilla%errorLevel%
    :installFilezilla1
        choco install filezilla

    :installFilezilla2
        ECHO:
        CHOICE /m "Install cURL?"
        GOTO installCurl%errorLevel%
    :installCurl1
        choco install curl

    :insallCurl2
        ECHO:
        CHOICE /m "Install Wireshark?"
        GOTO installWireshark%errorLevel%
    :installWireshark1
        choco install wireshark

    :installWireshark2
        ECHO:
        CHOICE /m "Install Postman?"
        GOTO installPostman%errorLevel%
    :installPostman1
        choco install postman

    :installPostman2
        ECHO:
        CHOICE /m "Install VNC Viewer?"
        GOTO installVncViewer%errorLevel%
    :installVncViewer1
        choco install vnc-viewer

    :installVncViewer2
        ECHO:
        @REM Installs Automation Tools
        CHOICE /m "Install Jenkins?"
        GOTO installJenkins%errorLevel%
    :installJenkins1
        choco install jenkins

    :installJenkins2
        ECHO:
        CHOICE /m "Install Selenium?"
        GOTO installSelenium%errorLevel%
    :installSelenium1
        choco install selenium

    :installSelenium2
        ECHO:
        CHOICE /m "Install Cypress?"
        GOTO installCypress%errorLevel%
    :installCypress1
        choco install cypress

    :installCypress2
        ECHO:
        CHOICE /m "Install Chromedriver?"
        GOTO installChromedriver%errorLevel%
    :installChromedriver1
        choco install chromedriver

    :installChromedriver2
        ECHO:
        @REM Installs Docker
        CHOICE /m "Install Docker?"
        GOTO installDocker%errorLevel%
    :installDocker1
        choco install docker-desktop

    :installDocker2
        ECHO:
        @REM Reboot Now Option
        CHOICE /m "A restart is required to complete installation. Restart system now?"
        GOTO restartChoice%errorLevel%

@REM-------------------------------------------------
@REM------------manual package script ends-----------
@REM-------------------------------------------------

:installOption7
    CLS
    @REM Uninstalls all packages.
    ECHO:
    ECHO All packages will be automatically uninstalled.
    ECHO Your system will automatically restart.
    ECHO Please save all current work.
    ECHO Please close all open applications.
    ECHO:
    CHOICE /m "This will remove ALL packages and restart. Press Y to confirm action. Press N to abort."
    GOTO confirmUninstall%errorLevel%

:installOption8
    @REM Restarts computer
    GOTO restartChoice1
    @REM if parse error, return to main menu...
    GOTO :mainInstallOption1

:installOption9
    CLS
    @REM Exits Script.
    ECHO:
    ECHO Press any key to exit.
    PAUSE >NUL
    EXIT

:restartChoice1
    CLS
    @REM Restarts the computer.
    ECHO:
    ECHO Your system will now restart.
    ECHO:
    SHUTDOWN -r -t 10 /d p:4:2
    @REM if any abort auto reboot, return to main menu...
    GOTO :mainInstallOption1

:restartChoice2
    CLS
    @REM Returns to main menu after user presses key.
    PAUSE
    GOTO :mainInstallOption1


:confirmUninstall1
    ECHO Action Confirmed:
    ECHO:
    ECHO:
    ECHO Beginning package uninstallation...
    ECHO:
    choco uninstall all -y -a
    ECHO:
    GOTO restartChoice1
    @REM if any parse error, return to main menu...
    GOTO :mainInstallOption1

:confirmUninstall2
    GOTO :mainInstallOption1
