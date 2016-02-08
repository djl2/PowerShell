 param (    # Sample UNC path [string] $RootFolder= '\\aus02gpsvm01.corp.volusion.com\vol_nuget_tfs\Volusion\Nuget\nupkg\octodev_archive',    [string]$RootFolder = $(throw "Enter root folder. Parameter is -RootFolder"),    [string]$fileToDelete = $(throw "Enter filename to delete"),    [string]$DaysOld = $(throw "Enter number of days old"),    [boolean]$DELETE = $false    )

# import my custom module file
Import-Module .\manage-package.psm1 -Force

# Command section
Write-Host ''

# Call my custom remove-package function within manage-package.psm1 
remove-packages -RootFolder $RootFolder -fileToDelete $fileToDelete -DaysOld $DaysOld -DELETE $DELETE
