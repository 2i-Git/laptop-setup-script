# laptop-setup-script

2i Engineering Laptop Tooling Setup.

Please install Chocolatey first. [https://chocolatey.org/install](https://chocolatey.org/install)

Clone repo and run Setup.ps1 from a Powershell instance.

Open the file in IDE and use comment lines to control package options.
Windows 10 debloat is disabled by default.

If the code stops executing around line 52, namely "choco install wsl-ubuntu-2004 -y", you can create the account and exit Ubuntu, a manual restart of the laptop is one method for this. After this you can simply paste from line 53, namely "choco install openssh -y" and onwards until the end in full and this should work. 
