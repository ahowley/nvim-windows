Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
refreshenv

winget install BurntSushi.ripgrep.MSVC
Add-Content -Path "$PSHOME\Profile.ps1" -Value "Set-Alias -Name rg `"`$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages\BurntSushi.ripgrep.MSVC_Microsoft.Winget.Source_8wekyb3d8bbwe\ripgrep-14.1.0-x86_64-pc-windows-msvc\rg.exe`""
