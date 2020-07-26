# Searching through Event Logs



## Get-EventLog

[Get-EventLog](Get-Eventlog.ps1) uses a Win32 API that is deprecated. The results may not be accurate. Use the Get-WinEvent cmdlet instead.

## Get-WinEvent

[Get-WinEvent](Get-WinEvent.ps1) is the latest cmdlet for searching through **Event Logs**.  
Besides using a newer API for searching through Event Logs, it also supports the new **Event Tracing Log-format** 
