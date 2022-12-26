######################################
#Purpose: Fun Windows system information script
#Version: 1.0
#Changes: 
######################################

Set-ExecutionPolicy Unrestricted

#Start script with information for administrator. 
Write-host "This script gathers information about your system and prints it in the Powershell window."
Write-host "An output file that captures the below information will also be generated in the same directory where you run this script."

#Let's fetch system information!
Write-Host "Welcome to the script of fetching computer Information"
Write-host "The BIOS Details are as follows"
Get-CimInstance -ClassName Win32_BIOS
Get-CimInstance -ClassName Win32_BIOS > systemInfo.txt

Write-Host "The systems processor is"
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType >> systemInfo.txt

Write-Host "The OS details are below"
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Build*,OSType,ServicePack*
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property Build*,OSType,ServicePack* >> systemInfo.txt

Write-Host "Status of the running services are as follows"
Get-CimInstance -ClassName Win32_Service | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap
Get-CimInstance -ClassName Win32_Service | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap >> systemInfo.txt

Write-Host "And that's the end of the script!"
