<#
archive-files-w-params
1.18.2016

Archives files recursively from a root folder

Usage
  
Run with correct parameters. By default, $TestOnly is set to $True to prevent accidental file deletion.

  .\Archive-files-w-params.ps1 -RootFolder c:\temp -SourceFolder OctoDev -fileToArchive **-dev*.nupkg -DaysOld 90

To Archive files, run file with -TestOnly $false.  RUN WITH CAUTION!

  .\Archive-files-w-params.ps1 -RootFolder c:\temp -SourceFolder OctoDev -fileToArchive **-dev*.nupkg -DaysOld 90 -TestOnly $false 

#>
 param (    # sample [string] $RootFolder= '\\aus02gpsvm01.corp.volusion.com\vol_nuget_tfs\Mozu\Nuget\nupkg\'    [string]$RootFolder = $(throw "Enter Root folder. Parameter is -RootFolder"),    [string]$SourceFolder = $(throw "Enter Source folder. Parameter is -SourceFolder"),    [string]$fileToArchive = $(throw "Enter filename to Archive"),    [string]$DaysOld = $(throw "Enter number of days old"),    [boolean]$TestOnly = $true     )

# Map an N drive to the root of the Nuget folder you want to Archive files from
New-PSDrive -Root $RootFolder -Name N -PSProvider filesystem

# Go to N drive
set-location N:

# Command section
Write-Host ''

if ($TestOnly) # DEFAULT Runs with -whatif
{
    write-host "TEST ONLY! Archive any $fileToArchive files in Source folder older than $DaysOld days..."
    get-childitem -path $SourceFolder -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToArchive} | move-item -destination .\OctoDev_archive\ -Verbose -WhatIf
}
else
{
    write-host "Archive any $fileToArchive files in Source folder older than $DaysOld days..."
    get-childitem -path $SourceFolder -recurse | Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToArchive} | move-item -destination .\OctoDev_archive\
}

# Remove PSdrive
set-location C:
Remove-PSDrive N