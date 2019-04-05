<# Query all Windows-services where PathName contains the string Content #>
Get-CimInstance -Query 'select * from Win32_Service where pathname like "%Content%"'
