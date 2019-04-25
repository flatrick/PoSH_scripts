# Example 1
<# Information about the currently logged in user #>
(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=$($env:username)))")).FindOne().GetDirectoryEntry().memberOf

# Example 2
<# Information about the user "HISorHERSusername" #>
(New-Object System.DirectoryServices.DirectorySearcher("(&(objectCategory=User)(samAccountName=HISorHERSusername))")).FindOne().GetDirectoryEntry().memberOf
