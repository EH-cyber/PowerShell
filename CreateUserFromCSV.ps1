# CreateUserFromCSV.ps1
# This script reads a CSV "NeededUsers.CSV" and searches for a Users OU in the Department OU to use as a path for users
# This also sets account password to "password" and has it expire in 90 days

<#
  This script works by loading the CSV into the UserCSV variable.
  Once loaded the variable is sent to the ForEach-Object loop 
  where it goes through each user loaded into the variable from the CSV.
  As it cycles through each user it creates their account based on the information in the CSV file
  i.e. firstname, lastname, SamAccountName, and Department
#>

$UserCsv = Import-Csv $env:USERPROFILE\Desktop\NeededUsers.CSV
$UserPath = Get-OrganizationalUnit -Filter 'Name -like "Users"' | where -Property DistinguishedName -Like "*Department*"
$expDate = (Get-Date).AddDays(90)

$UserCsv | ForEach-Object{
  New-ADUser -Name ("{0} {1}" -f $PSItem.firstname,$PSItem.lastname) `
  -GivenName $PSItem.firstname `
  -SurName $PSItem.lastname `
  -SamAccountName $PSItem.SamAccountName `
  -UserPrincipalName ("{0}@business.email" -f $PSItem.SamAccountName) `
  -Department $PSItem.Department `
  -AccountExpirationDate $expDate `
  -Enabled $true `
  -Path $UserPath.DistinguishedName
  -AccountPassword (ConvertTo-SecureString "password" -AsPlainText -Force)
}
