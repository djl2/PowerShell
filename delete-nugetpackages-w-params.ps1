<#
delete-nugetpackages
9.15.15

Use to delete old nuget packages on Klondike NAS share.

Usage
  
  Update correct variables below

  By default, the Remove-item cmdlet is set to -WhatIf to prevent accidental file deletion.

#>
 param (    [string]$NugetRoot = '\\aus02gpsvm01.corp.volusion.com\vol_nuget_tfs\Mozu\Nuget\nupkg\octodev_archive',    [string]$fileToDelete = '**-dev*.nupkg'     )

# Variables section
# Declare exact file path and file name to delete.

# Sample value--  $NugetRoot= '\\aus02gpsvm01.corp.volusion.com\vol_nuget_tfs\Volusion\Nuget\nupkg\octodev_archive'
# $NugetRoot= ''
# Sample value--  $fileToDelete= 'StoreManagement.**.nupkg'
# $fileToDelete=''

# Map an N drive to the root of the Nuget folder you want to delete files from
New-PSDrive -Root $NugetRoot -Name N -PSProvider filesystem

# Go to N drive
set-location N:

# Command section
# ATTENTION!  REMOVE the -Whatif WITH CAUTION!
Write-Host ''
write-host "Deleting all $fileToDelete packages on Nuget feed older than 3 months..."
get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-90) -and $_.Name -like $fileToDelete} | remove-item -Verbose -WhatIf
# get-childitem -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-90) -and $_.Name -like $fileToDelete} | remove-item -Verbose

# Remove PSdrive
set-location C:
Remove-PSDrive N