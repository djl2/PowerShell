<#
Manage-package.psm1

Includes custom functions for handling nuget packages on the feeds.

#>


# Functions
<# Remove-Package
.Synopsis
   Deletes old build packages
.DESCRIPTION
   Enter number of days old to delete
.EXAMPLE
   DEFAULT. Test only.  Runs with -whatif to show which files will be deleted.

    remove-package -RootFolder '\\localhost\C$\temp\' -fileToDelete *.txt -DaysOld 3
    
.EXAMPLE
   CAUTION!  To run and actually delete all the files, run with -DELETE $TRUE

    remove-package -RootFolder '\\localhost\C$\temp\' -fileToDelete *.txt -DaysOld 3 -DELETE $TRUE

#>
function Remove-Packages
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
             #      ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$fileToDelete,

        # Param2 help description
        [string]$RootFolder,

        [int]$DaysOld,

        [boolean]$DELETE
    )

    Process
    {
    # To delete files, run with parameter -DELETE $true
    if ($DELETE) 
    {
    write-host "Delete any $fileToDelete files in root folder older than $DaysOld days..."   # Note the negative sign for (-$DaysOld)
    get-childitem $RootFolder -recurse |
    Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToDelete} |
    remove-item -Verbose
    }
    else # DEFAULT. No deletion. Runs with -whatif
    {
    write-host "TEST ONLY! To delete $fileToDelete files in root folder older than $DaysOld days, run with -DELETE" '$true'   # Note the negative sign for (-$DaysOld)
    get-childitem $RootFolder -recurse |
    Where-Object {$_.lastwritetime -le (get-date).adddays(-$DaysOld) -and $_.Name -like $fileToDelete} |
    remove-item -Verbose -WhatIf
    }
  }  
}



