<#
 # show processes
#>

Write-host "Show Chrome processes with CPU above 500"

Get-Process chrome | Where-Object {$_.CPU -gt "500"}


