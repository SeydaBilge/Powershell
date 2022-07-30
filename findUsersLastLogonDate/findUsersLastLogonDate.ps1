
$date = (Get-Date).AddMonths(-3)
$TargetOU = "OU=SilinecekKullanicilar,DC=sbu,DC=local"

#$user = Get-ADUser -Filter * -SearchBase "OU=Users,DC=sbu,DC=local" -Properties "LastLogonDate","SamAccountName" | where {$.LastLogonDate -lt $date} Sort-Object -property LastLogonDate,SamAccountName,DistinguishedName -Descending | FT SamAccountName, @{name="LastLogonDate";expression={($.LastLogonDate).ToShortDAteString()}}, DistinguishedName -AutoSize

$user = Get-ADUser -Filter * -SearchBase "OU=Users,DC=sbu,DC=local" -Properties "LastLogonDate","SamAccountName" | where {$.LastLogonDate -lt $date -and $.Enabled -like "True"} select SamAccountName

foreach ($user in $users)
{
    Get-ADUser $user.SamAccountName | Move-ADObject -TargetPath $TargetOU -Confirm
}