<#
 # show-running-services
 Gets services and shows only running services
 9.7.15 Added stuff...
 .
#>
write-host "Show running services"
Get-Service | where {$_.Status -eq "running"}

