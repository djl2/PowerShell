<#
replace-hostname.ps1
Recursively finds old hostname in all config files and replaces
With current hostname 

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
    [string]$oldHostname = $(throw "-oldHostname must reflect previous hostname."),
    [string]$newHostname = "$env:COMPUTERNAME"
  
 )

# Command Section ###################

$collection = Get-ChildItem -Recurse $filespec | Where-Object { Select-String $oldHostname $_ -Quiet }

foreach ($item in $collection)
{
    write-host "Replace $oldHostname in $item"
   (Get-Content $item).Replace("$oldHostname", "$newHostname") | Set-Content $item
   write-host "Confirm $newHostname was added to files"

   Get-Content $item | Select-String -Pattern "$newHostname" -Quiet
}
