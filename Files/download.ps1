<# 
This script uses the .Net library System.Net.WebClient instead of any built-in cmdlet to download a file 
#>

$url = "http://where.your.file/is.located"
$output = "$PSScriptRoot\myfilename.here"
$start_time = Get-Date

$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url, $output)
<# Or you can write it this way #>
#(New-Object System.Net.WebClient).DownloadFile($url, $output)

Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"
