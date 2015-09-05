<#
 # show-running-services
 Gets services and shows only 

#>

Get-Service | where {$_.Status -eq "running"}

