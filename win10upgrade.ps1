########################################
#
#Name: Windows 10 Upgrade Script
#
#Version: 1.2
#
#Change(s): Updated path to exact location; spelling changes
#
########################################

#Users enter this before the script is run, but just in case.
Set-ExecutionPolicy Unrestricted

########################################
#Variable Declaration
#
#THIS VARIABLE $path IS THE ONE TO MODIFY FOR NEW WIN10 PACKAGES!!!
#
########################################

$path =".\Configuration Manager\SMS\PKG\PR100156" #This can be modified for a different directory

$exeArgs = @( 
    "/auto upgrade"
    "/NoReboot"
    "/MigrateDrivers all"
    "/dynamicupdate disable"
    "/showoobe none"
)

$item ="setup.exe"
$dir = (Get-Item -Path $path -Verbose).FullName
$itemFull = $dir + "\" + $item

$ErrorActionPreference = 'SilentlyContinue' #Skip errors and continue script execution

filter timestamp {"$(Get-Date -Format HH:mm:ss): $_"} #Timestamp format to HOUR::MIN::SEC

########################################
#Check domain join status. If true, fail script run. If false (not joined to domain), run script to upgrade.
########################################

$domainJoined = (Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain

if ($domainJoined = $false)
{
    Write-Host ''
    Write-Host "This system is still joined to a domain. This script will now error out and end."
    Write-Host "Disjoin this laptop from the domain and re-run this script to continue."
    Write-Host ''
}
else
{
    ########################################
    #Begin 1909 installation
    ########################################

    write-host ''
    Write-Host 'Starting Windows 10 version 1909 upgrade. This is a non-interactive instal that will display progress on the screen.'
    Write-Host 'This update may take 30 - 60 minutes depending on the hardware being upgraded.'
    Write-Host 'Be aware the screen will lock if the system is left unattended. This does NOT affect the upgrade.'
    Write-Host ''

    $regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation"
    Set-ItemProperty -Path $regKey -Name Model -Value "SHB-A Windows 10 Enterprise (1909)"

    #This line can be commented out if not wanted. 
    Add-Content C:\DCGSA_Update.txt "`n Windows 10 Version 1909 has been installed."

    cd $path
    Start-Process -FilePath $itemFull -ArgumentList $exeArgs -Wait -NoNewWindow

    Write-Host "This completes the Windows 10 version 1909 installation script. Reboot the system to complete the installation."
    Write-Host "Please note: this reboot will kick off several automatic reboots as the system finalizes the configuration changes."
    Write-Host "Once the reboots complete and you are able to login, please re-join your local domain."
    Write-Host ''
}