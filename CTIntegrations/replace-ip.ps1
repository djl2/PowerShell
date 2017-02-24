<#
replace-Ip.ps1
Recursively finds old Ip in all config files and replaces
With current Ip 

File names to search for

*.exe.config
web.config


Strings to search for and replace

cts30-dev <-- Original host name
sql2016  <-- Original SQL server
192.168.0.95 <-- Original VM IP
localhost <-- Use carefully! Some files have 'localhost' in the comments section


/#>


# Override defaults as needed
 param (
  #  [string]$filespec = '*.exe.config',
    [string]$filespec = '**.config',
    [string]$oldIp = $( Read-Host "Enter old IP address."),
    [string]$newIp = $( Read-Host "Enter new IP address.")
    
 )

# Command Section ###################

$collection = Get-ChildItem -Recurse $filespec | Where-Object { Select-String $oldIp $_ -Quiet }

foreach ($item in $collection)
{
    write-host "Replace $oldIp in $item"
   (Get-Content $item).Replace("$oldIp", "$newIp") | Set-Content $item
   write-host "Confirm $newIp was added to files"

   Get-Content $item | Select-String -Pattern "$newIp" -Quiet
}
