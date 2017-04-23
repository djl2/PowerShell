<#
replace-allF.ps1
Custom function
Recursively finds and replaces strings in all config files for new environments 

File names to search for

*.exe.config
web.config


Strings to search for and replace

cts30-dev <-- Original host name
sql2016  <-- Original SQL server
192.168.0.95 <-- Original VM IP
localhost <-- Use carefully! Some files have 'localhost' in the comments section


/#>

# Parameters section #####################
# Override defaults as needed. By default, $newHostname will be automatically as the local hostname.
 param (
  #  [string]$filespec = '*.exe.config',
    [string]$filespec = '**.config',
    [string]$oldHostname = 'CTS30-QA',
    [string]$newHostname = "$env:COMPUTERNAME",
    [string]$oldIP = '192.168.0.97',
    [string]$newIP = $(Read-Host "Enter new IP address."),
    [string]$oldSQL = 'SQL2016QA',
    [string]$newSQL = $(Read-Host "Enter new SQL hostname")     
 )


# Function section #######################

# Replace string values in all config files
function update-configs ($param1, $param2)
{
$collection = Get-ChildItem -Recurse $filespec | Where-Object { Select-String $param1 $_ -Quiet }

foreach ($item in $collection)
  {
    write-host "Replace $param1 in $item"
   (Get-Content $item).Replace("$param1", "$param2") | Set-Content $item
   
   write-host "Confirm $param2 was added to files"
   Get-Content $item | Select-String -Pattern "$param2" -Quiet
  }    
}

# Command Section ###################

# Update config files
update-configs $oldHostname $newHostname
update-configs $oldIP $newIP
update-configs $oldSQL $newSQL
