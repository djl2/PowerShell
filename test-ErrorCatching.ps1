# Test error catching

write-host 'Show workspace dir'
get-childitem

write-host 'Try to run bad command'
Get-MyBogusCmdlet