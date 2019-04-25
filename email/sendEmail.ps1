<# 
* Sending a anonymous email 
This example creates basically a anonymous user to be sent as credentials for Send-MailMessage
It also connects to the smtp-server unencrypted and on port 25
#>
$creds = New-Object System.Management.Automation.PSCredential("anonymous", $(ConvertTo-SecureString –String "anonymous" –AsPlainText -Force)); 
Send-MailMessage -From 'WhoAmI <sender@mail.here>' -To 'WhoAreYou <recipient@of.mail>' -Subject 'Take it!' -SmtpServer "smtp-server" -UseSsl $false -Port 25 -Credential $creds
