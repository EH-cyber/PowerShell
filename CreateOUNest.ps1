# CreateOUNest.ps1
# This script creates an OU with a nest of three other OUs

# We use PassThru to send output to the variable
# The output allows us to use this when creating our sub OUs and determining the path
$mainOU = New-ADOrganizationalUnit -Name "East Campus" -PassThru
$subOUs = "Professors","Maintenance","IT"

# This for loop cycles through each object we send through the pipe i.e. "Professors","Maintenance", and "IT"
# As each object is sent through the pipe it becomes the PSItem and is created with a path to the mainOU
$subOU | ForEach-Object{
  New-ADOrganizationalUnit -Name $PSItem -Path $mainOU
}
