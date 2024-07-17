# disabledUserCSV.ps1
## Search AD for disabled users and export to a CSV

Get-ADUser -Filter * | where Enabled -eq $false | Export-Csv $env:USERPROFILE\Desktop\DisabledUser.CSV
