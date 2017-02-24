<#
replace-strings.ps1
Recursively finds and replaces values in all files in current folder 

File names to search for

*.exe.config
web.config


Strings to search for and replace

cts30-dev <-- Original host name
sql2016  <-- Original SQL server
192.168.0.95 <-- Original VM host hame
localhost <-- Use carefully! Some files have 'localhost' in the comments section


/#>


# Override defaults as needed
 param (
  #  [string]$filespec = '*.exe.config',
    [string]$filespec = '*.txt',
  #  [string]$pattern = 'CTS30-DEV',
    [string]$pattern = $(throw "-pattern must reflect previous hostname."),
    [string]$newPattern = "$env:COMPUTERNAME"

    
 )

# Command Section ###################

$collection = Get-ChildItem -Recurse $filespec | Where-Object { Select-String $pattern $_ -Quiet }

foreach ($item in $collection)
{
    write-host "Replace $pattern in $item"
   (Get-Content $item).Replace("$pattern", "$newPattern") | Set-Content $item
   write-host "Confirm $newPattern was added to files"
   Get-Content $item | Select-String -Pattern "$newPattern"
}
