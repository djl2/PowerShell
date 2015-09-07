<#
 # show-running-services
 Gets services and shows only running services

#>

Get-Service | where {$_.Status -eq "running"}

