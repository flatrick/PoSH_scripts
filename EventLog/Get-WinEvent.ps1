#Example 0.1
<# 
* List all available Event Logs and Event Trace Logs
#>
Get-WinEvent -ListLogs *

#Example 0.2
<# 
* List all available Event Log Providers (applications/services creating entries in the logs) and to which logs they create entries in.
#>
Get-WinEvent -ListLogs *

#Example 0.3
<# 
* List all available Event Log Providers that create entries in the Event Log Application
#>
(Get-WinEvent -ListLog Application).ProviderNames

#Example 1
<# 
* Show the eventlog Microsoft-Windows-SMBServer/Operational (which is a "Event Tracing Log" that Get-EventLog doesn't support)
#>
Get-WinEvent -LogName "Microsoft-Windows-SMBServer/Operational"

#Example 2
<# 
* Search through the eventlog Microsoft-Windows-SMBServer/Operational
* But only for lines that where created in the past 30 days (we have to turn the date into a date-time object, hence the use of Get-Date and New-TimeSpan)
#>
Get-WinEvent -LogName "Microsoft-Windows-SMBServer/Operational" | Where-Object { $_.TimeCreated -ge $( (Get-Date) - (New-TimeSpan -Day 30) ) }

#Example 3
<# 
* Search through the eventlog Microsoft-Windows-SMBServer/Operational
* But only for lines that where created in the past 30 days
* And is of the level Error ( Critical | Error | Warning | Information | Verbose )
#>
Get-WinEvent -LogName "Microsoft-Windows-SMBServer/Operational" | Where-Object { $_.TimeCreated -ge $( (Get-Date) - (New-TimeSpan -Day 30) ) -AND $_.LevelDisplayName -EQ "Error" }

#Example 4
<# 
* Search through the eventlog Microsoft-Windows-SMBServer/Operational (which is of the new type event logs)  
* But only for lines that where created in the past 30 days
* And is of the level Error
* And only show the property Message (which is usually what you're looking for) and in it's full form.
If you don't use 'Format-List -Property', you'll get a truncated version that will most certainly be missing information.
You could also use 'Select-Object -ExpandProperty', just don't use 'Select-Object -Property' since it will present the data in the truncated form, unless that's what you want.
#>
Get-WinEvent -LogName "Microsoft-Windows-SMBServer/Operational" | Where-Object { $_.TimeCreated -ge $( (Get-Date) - (New-TimeSpan -Day 30) ) -AND $_.LevelDisplayName -EQ "Error" } | Format-List -Property Message
