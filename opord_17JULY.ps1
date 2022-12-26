######################################
#Purpose: Meet 17 July 2020 Emergency Opord to make configuration change.
#Version: 1.0
#Created by: SEC Integration
######################################

Set-ExecutionPolicy Unrestricted

#variables
$registryPath = "HKLM:\System\CurrentControlSet\Services\DNS\Parameters"
$Name = "TcpReceivePacketSize"
$value = "0xFF00"

#Start script
Write-Host "This is a quick registry script to apply a temporary mitigation."
Write-Host '' 

IF(!(Test-Path $registryPath))

	{
		write-host 'Registry path does not exists. Creating path.'
		New-Item -Path $registryPath -Force | Out-Null
		New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType "DWORD" -Force | Out-Null
		write-host 'Registry change has been made. Restarting DNS service.'
		restart-service -DisplayName "DNS Client"
		Write-Host 'Script has completed with necessary change.'
	}

 ELSE 
	{
		write-host 'Registry path exists. Updating value.'
		New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType "DWORD" -Force | Out-Null
		write-host 'Registry change has been made. Restarting DNS service.'
		restart-service -DisplayName "DNS Client"
		Write-Host 'Script has completed with necessary change.'
	}