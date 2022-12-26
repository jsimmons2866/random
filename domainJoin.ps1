######################################
#Purpose: Set IP information, then join system to domain using prompted credentials
#Version: 1.1
#
#Changes: Updated logic in If statements for specific setup
######################################

Set-ExecutionPolicy Unrestricted

#Start script with information for administrator. 
Write-host "This is an interactive network setup and domain joining script."
Write-host "You will be prompted for specific information including: IP address, Gateway IP (Switch), DNS Server (Domain Controller IP) first."
Write-host "Please enter requested information when prompted. If you run into a mis-type at anytime press <CTRL +C> to cancel the script."
Sleep 10

#Open Network Connection Panel, then prompt user for adapter name. 
ncpa.cpl

Write-Host "You will need your ethernet name. Network Connections has been opened by this scipt."
$ethName = Read-Host -Prompt "Please enter your ethernet name as seen in your Network Connections:"
$ipAddress = Read-Host -Prompt "Enter your IPv4 address in this format 'XX.XX.XX.XX':"
$gatewayIP = Read-Host -Prompt "Enter your gateway (switch) IP in this format 'XX.XX.XX.XX':"
$dnsIP = Read-Host -Prompt "Enter your DNS (Domain Controller) IP in this format 'XX.XX.XX.XX':"

#Set IP Information based on provided information.
New-NetIPAddress –InterfaceAlias $ethName –IPv4Address $ipAddress –PrefixLength 24 -DefaultGateway $gatewayIP
Set-DnsClientServerAddress -InterfaceAlias $ethName -ServerAddresses $dnsIP

Write-Host '' 
Write-Host "System has now been IP'd with provided credentials. Switching to Domain Join portion of script."
Write-Host '' 

#Pull in Domain Information
#Add system to domain based on shortname
$computerName = [system.environment]::MachineName
$shutdownArgs = @(
    "/r"
    "/t 10"
)
$domainFQDN = Read-Host -Prompt "Enter domain FQDN:"
$adminUser = Read-Host -Prompt "Enter Domain Administrator login in this format (D123\adminname):"

Write-host "Joining " + $computerName + " to the " + $domainFQDN + " now." 

#If/Else statement to join system to the domain base on shortname
if ($computerName -like '*proto*')
{
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=proto,OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}
elseif ($computerName -like '*dragon*')
{
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=dragon,OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}
elseif ($computerName -like '*centaur*')
{
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=centaur,OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}
elseif ($computerName -like '*rhino*')
{
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=rhino,OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}
elseif ($computerName -like '*dinosaur*')
{
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=dinosaur,OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}
else
{
    #This should ONLY catch for odd named systems. This joins the system to the Domain into Computers OU.
    Add-Computer -DomainName $domainFQDN -Credential $adminUser -OUPath "OU=Win2K2R2 Servers,DC=domain,DC=Domain,DC=com"
    Write-Host $computerName + " has been joined to the domain and placed into the 'Computers' OU. You will need to move this system into the correct OU for it to receive the correct Group Policy."
    Write-Host "System will now auto reboot in 10 seconds."
    shutdown $shutdownArgs
}


#Command to add computer to specified domain using specific user; then force restart
#add-computer –domainname $domainFQDN -Credential $adminUser -restart –force