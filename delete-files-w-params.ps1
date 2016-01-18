﻿<#
delete-files-w-params
1.17.2016

Deletes files recursively from a root folder

Usage
  
Run with correct parameters. By default, $TestOnly is set to $True to prevent accidental file deletion.

  .\delete-files-w-params.ps1 -RootFolder c:\temp -fileToDelete **-dev*.nupkg -DaysOld 90

To delete files, run file with -TestOnly $false.  RUN WITH CAUTION!

  .\delete-files-w-params.ps1 -RootFolder c:\temp -fileToDelete **-dev*.nupkg -DaysOld 90 -TestOnly $false 

#>
 param (

# Map an N drive to the root of the Nuget folder you want to delete files from
New-PSDrive -Root $RootFolder -Name N -PSProvider filesystem

# Go to N drive
set-location N:

# Command section
Write-Host ''

if ($TestOnly) # DEFAULT Runs with -whatif
{
    write-host "TEST ONLY! Delete any $fileToDelete files in root folder older than $DaysOld days..."
    get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToDelete} | remove-item -Verbose -WhatIf
}
else
{
    write-host "Delete any $fileToDelete files in root folder older than $DaysOld days..."
    get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToDelete} | remove-item -Verbose   
}

# Remove PSdrive
set-location C:
Remove-PSDrive N