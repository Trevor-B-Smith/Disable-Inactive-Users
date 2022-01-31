$LocalUsers=(Get-LocalUser | select name,lastlogon,enabled)
$LocalUsers = $LocalUsers -split "} @{"
$LocalUsers = $LocalUsers -replace '[{@}]',''

foreach ($User in $LocalUsers) {
    $UserInfo = $User -split "; "
    $Name = $UserInfo[0] -replace ".*=" 
    $LastLogon = $UserInfo[1] -replace ".*=" 
    $Enabled = $UserInfo[2] -replace ".*="
    Write-Host($UserInfo)
    
    if ($LastLogon.Length -gt 0){
        $LastLogon = [datetime]$LastLogon
        $DateLimit = (Get-Date).AddDays(-90)

        #Checks date and if account is disabled
        if ($LastLogon -lt $DateLimit -and $Enabled -eq "True"){
            #If account is enabled & older than 90 days, disable it.
            Write-Host("Disabled local user account " + $Name)
            # Disable-LocalUser -Name $Name
        }
    }
}

