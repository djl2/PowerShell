<#
delete-files-w-params
Latest rev 2.4.2016

Deletes files recursively from a root folder

Usage
  
By default, the parameter $DELETE is not defined (boolean value is effectively $false or 0) to prevent accidental file deletion.

  delete-files-w-params.ps1 -RootFolder c:\temp -fileToDelete **-dev*.nupkg -DaysOld 30

To delete files, run file with -DELETE $true.  RUN WITH CAUTION!

  delete-files-w-params.ps1 -RootFolder c:\temp -fileToDelete **-dev*.nupkg -DaysOld 30 - DELETE $true 

#>
 param (    # Sample UNC path [string] $RootFolder= '\\aus02gpsvm01.corp.volusion.com\vol_nuget_tfs\Volusion\Nuget\nupkg\octodev_archive',    [string]$RootFolder = $(throw "Enter root folder. Parameter is -RootFolder"),    [string]$fileToDelete = $(throw "Enter filename to delete"),    [string]$DaysOld = $(throw "Enter number of days old"),    [boolean]$DELETE     )

# Map an N drive to the root of the Nuget folder you want to delete files from
New-PSDrive -Root $RootFolder -Name N -PSProvider filesystem

# Go to N drive
set-location N:

# Command section
Write-Host ''

# To delete files, run with parameter -DELETE $true
if ($DELETE) 
{
    write-host "Delete any $fileToDelete files in root folder older than $DaysOld days..."
    get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays($DaysOld) -and $_.Name -like $fileToDelete} | remove-item -Verbose
}
else # DEFAULT. No deletion. Runs with -whatif
{
    write-host "TEST ONLY! Delete any $fileToDelete files in root folder older than $DaysOld days..."
    get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays($DaysOld) -and $_.Name -like $fileToDelete} | remove-item -Verbose -WhatIf
}

# Remove PSdrive
set-location C:
Remove-PSDrive N