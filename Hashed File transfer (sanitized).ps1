<#
Generates a hash of the data
robocopies it, sends the robocopy log to c:\scripts\logs\log.txt
Generates a hash of the data at destination
Compares the two
Sends an email with the body of the email being the hash comparison (== and ==) and the attachment of the log generated.

Source and destination locations can be network locations
#>

$Source = Get-ChildItem -Recurse $SOURCELOCATION | Get-FileHash -Algorithm MD5
Robocopy.exe $SOURCELOCATION $DESTINATIONLOCATION /copyall /LOG:"c:\scripts\logs\log.txt"
$Destination = Get-ChildItem -Recurse $DESTINATIONLOCATION | Get-FileHash -Algorithm MD5
$transferReport = Compare-Object $Source.Hash $Destination.Hash -IncludeEqual | Out-String
Send-MailMessage -To $DESIREDEMAIL -SmtpServer $SMTPSERVER -From $DESIREDEMAIL2 -Body $transferReport -Subject "Transfer Report" -Attachments "C:\Scripts\Logs\log.txt"