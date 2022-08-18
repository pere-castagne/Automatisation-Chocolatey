#Obligation d'exécuter en administrateur.
function Administrateur  
{  
    [OutputType([bool])]
    param()
    process {
        [Security.Principal.WindowsPrincipal]$user = [Security.Principal.WindowsIdentity]::GetCurrent();
        return $user.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator);
    }
}

if(-not (Administrateur))
{ 
    Write-Error "Le script n'a pas été lancé en tant qu'administrateur.";
    exit 1;
}

$ErrorActionPreference = "Stop";
$host.ui.RawUI.WindowTitle = "Configuration de l'ordinateur"
$ver = (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ReleaseId')
Write-Output "Version de Windows: $ver"

#Installation du package Chocolatey.
Write-Output "Installation des fonctionnalités Chocolatey"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco feature enable -n allowGlobalConfirmation

#Installation des applications suivantes, à modifier selon les besoins :
Write-Output "Installation des applications suivante : adobereader et firefox"
choco install adobereader firefox

#Si vous souhaitez mettre des conditions, comme demander si l'utilisateur souhaite installer Office.
while ($global:Office -notmatch "[y|n]") 
	{
	$global:Office = Read-Host "Installation d'Office 365 business ? [y/n]"
    }
	if($global:Office -eq "y")
	{
		Write-Output "Lancement de l'installation d'Office 365 business"
		choco install office365business
	}

#Supprime le package Chocolatey.
Write-Output "Suppression de chocolatey"
Remove-Item -Force -Recurse -Path "C:\ProgramData\chocolatey"
Write-Output "Chocolatey a été supprimé"

Write-Host "Installation des applications terminée" -ForegroundColor Green
