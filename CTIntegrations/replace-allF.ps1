<#
replace-allF.ps1
Includes custom function update-configs
Recursively finds and replaces strings in all config files for new environments 

Note: This script is set to update the following filenames in the CTIntegrations install folder.

*.exe.config
web.config
*config.json

Filenames are hardcoded below at $collection = Get-ChildItem -Recurse ('*.exe.config','web.config','*config.json') 


/#>

# Parameters section #####################
# Override defaults as needed. By default, $newHostname will be automatically as the local hostname.
 param (
    # Updates for CT Suite server values
    # [string]$filespec = '*.exe.config', DISABLED. Could not get ('*.exe.config','web.config','*config.json') to work within $filespec variable. Hardcoded instead.
    
    # Updates for local host's name
    [string]$oldHostname = 'CTS30-QA',
    [string]$newHostname = "$env:COMPUTERNAME",
    
    [string]$oldIP = '192.168.0.97',
    [string]$newIP = $(Read-Host "Enter new CT Admin IP address"),
    
    [string]$oldSQL = 'SQL2016QA',
    [string]$newSQL = $(Read-Host "Enter new SQL hostname"),


    # Updates for local Avaya stack values. For CTDeviceManager.exe.config
    [string]$oldAESIPAddress = '192.168.0.111',
    [string]$newAESIPAddress = $(Read-Host "Enter new AES IP Address"),
    
    [string]$oldAESUserName = 'ctsuitedev',
    [string]$newAESUserName = $(Read-Host "Enter new AES User Name"),

    # Note: Update old password to correct pw
    [string]$oldAESPassword = 'b0gusPW',
    [string]$newAESPassword = $(Read-Host "Enter new AES Password"),
    
    [string]$oldAESProtocol = '7.0',
    [string]$newAESProtocol = $(Read-Host "Enter new AES Protocol"),

    [string]$oldAESCMName = 'auracm7',
    [string]$newAESCMName = $(Read-Host "Enter new AES CM hostname"),
    
    [string]$oldAESCMIPAddress = '192.168.0.110',
    [string]$newAESCMIPAddress = $(Read-Host "Enter AES CM IP address")

 )


# Function section #######################

# Replace string values in all config files
function update-configs ($param1, $param2)
{
# $collection = Get-ChildItem -Recurse $filespec | Where-Object { Select-String $param1 $_ -Quiet } DISABLED. $filespec var would not work. Hardcoded array instead
$collection = Get-ChildItem -Recurse ('*.exe.config','web.config','*config.json') | Where-Object { Select-String $param1 $_ -Quiet }

foreach ($item in $collection)
  {
    write-host "Replace $param1 in $item"
   (Get-Content $item).Replace("$param1", "$param2") | Set-Content $item
   
   write-host "Confirm $param2 was added to files"
   Get-Content $item | Select-String -Pattern "$param2" -Quiet
  }    
}

# Command Section ###################

# Update CT Suite server files
update-configs $oldHostname $newHostname
update-configs $oldIP $newIP
update-configs $oldSQL $newSQL

# Updates for local Avaya stack values. For CTDeviceManager.exe.config
update-configs $oldAESIPAddress $newAESIPAddress
update-configs $oldAESUserName $newAESUserName
update-configs $oldAESPassword $newAESPassword
update-configs $oldAESProtocol $newAESProtocol
update-configs $oldAESCMName $newAESCMName
update-configs $oldAESCMIPAddress $newAESCMIPAddress