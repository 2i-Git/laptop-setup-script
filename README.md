# laptop-setup-script

2i Engineering Laptop Tooling Setup.

Please install Chocolatey first. [https://chocolatey.org/install](https://chocolatey.org/install)

Clone repo and run Setup.ps1 from a Powershell instance.

Open the file in IDE and use comment lines to control package options.
Windows 10 debloat is disabled by default.

---

HINTS:
- you need to run PowerSell as Administrator
- install choco first
- you might need to set ExecutionPolicy to 'RemoteSigned'. Check it with `get-executionpolicy`. If after running you see 'Restricted', type in `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned` than run `.\Setup.ps1`. Once finished, it is recommended to set it back to it's default value - 'Restricted'. [link](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3)
- if you get stuck logged in ubuntu after setting up your user account (setting user name and password), type in 'exit' and press enter
