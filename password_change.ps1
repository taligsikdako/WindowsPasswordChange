try {
    <# #>
    Remove-Variable * -ErrorAction SilentlyContinue
    Clear-host
    <#File Transscript#>
    $sharepath  = 'C:\home\ATCP_TOOLS\WorkLogs\'
    $username   = $env:USERNAME
    $hostname   = hostname
    $version    = $PSVersionTable.PSVersion.ToString()
    $datetime   = Get-Date -f 'yyyyMMddHHmmss'
    $filename   = "Transcript-${username}-${hostname}-${version}-${datetime}.txt"
    $Transcript = Join-Path -Path $sharepath -ChildPath $filename
    Start-Transcript -Path $Transcript
    <##>
    #Remove declared variable

    $Path = "C:\home\ATCP_TOOLS\"
    Set-Location -Path $Path

    $targetusers = Import-Csv -Path .\target_user.csv

function PasswordChange {

    foreach ($targetUser in $targetusers) {


        Write-Host "net user" $targetUser.Username $targetUser.Password
        Write-Host "New Password for:" $targetUser.Username {Password:}$targetUser.Password

        # Password Change
        net user $targetUser.Username $targetUser.Password

        #Password Confirmation
        net user $targetUser.Username

    }
}

PasswordChange
Start-Process .\spin_password_confirmation.bat $targetusers.username

} catch {

    # Logging the error to a file
   
    Write-Host -ForegroundColor Red "Encountered Error:"$_.Exception.Message
    $Error[0] | Out-File -FilePath C:\home\ATCP_TOOLS\WorkLogs\ErrorLog.txt -Append

}
Read-Host "Confirm: Press any key to exit"
Stop-Transcript