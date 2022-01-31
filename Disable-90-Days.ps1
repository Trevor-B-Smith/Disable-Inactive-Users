$LocalUsers=(Get-LocalUser | select name,lastlogon)
$LocalUsers = $LocalUsers -split "} @{"
$LocalUsers = $LocalUsers -replace '[{@}]',''

foreach ($User in $LocalUsers) {
    $UserInfo = $User -split "; "
    Write-Host($UserInfo)

}
