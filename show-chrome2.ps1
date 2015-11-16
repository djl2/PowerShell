<#
 # show processes
#>


Write-host "Show process with CPU utils above 500"


function Get-ProcessAbove500 {
param(
[Parameter(Mandatory, HelpMessage=’Enter the process name please’)]
$name
)
if (ps $name | Where-Object {$_.CPU -gt "500"})
    {
    "$name is above 500"
    } else {
        "$name is under 500"
    }
}



