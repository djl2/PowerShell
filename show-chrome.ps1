<#
 # show processes
#>

Write-host "Show Chrome processes with CPU above 500"

ps chrome | Where-Object {$_.CPU -gt "500"}


