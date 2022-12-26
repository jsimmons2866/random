########################################
#Created By: Josh Simmons
#Verion #: 1.0
#Purpose: To repair the VLAN settings after upgrade to Windows 10 1809. This will be needed if upgrading to 1903.
#
#Updated by: N/A
########################################

Set-ExecutionPolicy Unrestricted

########################################
#Creating If/Else statement to confirm system is named "syscon"
#If script is run against Analyst or any other system, this script should fail out with write-host messages
########################################
$computerName = [system.environment]::MachineName

if ($computerName.name -like '*syscon*')
{
	$Date = Get-Date
	$path = "C:\upgrade1809_Information.txt"
	$text = 'Recreating VLANs on Syscon using vlanRepair script on ' + $date + '.' | Out-File $text -FilePath $path
	
	Add-Content 
	#Import the VLAN module back into Windows 
	Import-Module -Name "C:\Program Files\Intel\Wired Networking\IntelNetCmdlets\IntelNetCmdlets"

	#Create an untagged virtual adapter
	Add-IntelNetVLAN -ParentName "Intel(R) Ethernet Connection (7) I219-LM" -VLANID 0 

	#Re-add VLANs
	$mgmtVLAN = Read-Host -Prompt 'Input your management vlan #'
	$storageVLAN = Read-Host -Prompt 'Input your storage vlan #'
	$publicVLAN = Read-Host -Prompt 'Input your public vlan #'

	$User = Read-Host -Prompt 'Input the user name'
	Write-Host "You input server '$Servers' and '$User' on '$Date'" 

	Add-IntelNetVLAN -ParentName "Intel(R) Ethernet Connection (7) I219-LM" -VLANID $mgmtVLAN
	Add-IntelNetVLAN -ParentName "Intel(R) Ethernet Connection (7) I219-LM" -VLANID $publicVLAN
	Add-IntelNetVLAN -ParentName "Intel(R) Ethernet Connection (7) I219-LM" -VLANID $storageVLAN
	
	Write-Host "The adapters have now been created. This script will now open Network Control Panel."
	Write-Host "Please enter IP information for each VLAN as appropriate."
	ncpa.cpl
}

else 
{
	Write-Host "This script is ONLY required on Syscon systems."
	Write-Host "This script will now error out back to the prompt."
}