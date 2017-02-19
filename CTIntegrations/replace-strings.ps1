<#
replace-strings.ps1
Recursively finds and replaces values in all files in current folder 

File names to search for

*.exe.config
web.config


Strings to search for and replace

cts30-dev
sql2016
192.168.0.95
localhost <-- Use carefully! Some files have 'localhost' in the comments section


/#>


# Override defaults as needed
 param (
  #  [string]$filespec = '*.exe.config',
    [string]$filespec = '*.txt',
    [string]$pattern = 'CTS30-DEV',
    [string]$newPattern = 'CTS30-QA'
    
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
