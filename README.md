Depuis PowerShell ou CMD grâce à Chocolatey comme un système Linux, nous pouvons :
Installer des applications depuis internet.
Mettre à jour les applications.
Désinstaller des applications.
(Concerne uniquement les applications installé depuis Chocolatey).

Prérequis :
Windows 7+ / Windows Server 2003+
PowerShell v2+
.NET Framework 4+

Installation de Chocolatey (PowerShell):
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco feature enable -n allowGlobalConfirmation

Installation d'une application :
choco install NomApplication

Mettre à jour une application :
choco upgrade NomApplication

Désinstaller une application :
choco uninstall NomApplication

Liste des packages/applications :
https://community.chocolatey.org/packages

Désinstaller Chocolatey :
choco uninstall chocolatey

(PowerShell)
Remove-Item -Force -Recurse -Path "C:\ProgramData\chocolatey"
