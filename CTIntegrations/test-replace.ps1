#

 param (
  #  [string]$filespec = '*.exe.config',
    [string]$filespec = 'mytest.txt',
    [string]$pattern = 'CTS30-DEV',
    [string]$newPattern = 'CTS30-QA'
    
 )



(get-content $filespec).Replace("$pattern","$newPattern") | Set-Content $filespec

#

# (get-content $myfile).Replace('prod','prodNEW') | Set-Content $myfile