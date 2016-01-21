# Test error catching
write-host ''
write-host 'Run get-childitem to test'
get-childitem
write-host ''
write-host 'Try to run a bad command'

Get-MyBogusCmdlet