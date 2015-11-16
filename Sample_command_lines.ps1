<#
 # Sample command lines

- Find the Windows Installer process

 C:\Users\shralper\Documents\GitHub\PowerShell [master]> ps | ?{$_.Description -like "*install*"} | select -Property Description,name,id

Description        Name      Id
-----------        ----      --
Windows® installer msiexec 4648
Windows® installer msiexec 6128


- Find the Windows Installer processes running and kill it.

\PowerShell [master]> ps | ?{$_.Description -like "*install*"} | select -Property Description,name,id | stop-process -force


- Capture a single property value from an object

PS C:\_git\Powershell> $mystr= Get-Service | ?{$_.DisplayName -like '*world*'} | select -Property name

PS C:\_git\Powershell> $mystr.Name
W3SVC



#>
