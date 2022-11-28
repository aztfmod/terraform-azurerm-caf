Start-Transcript -Path C:\setupADDS.Log

install-windowsfeature AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment

$recoverySecurePassword = ConvertTo-SecureString $recoveryPassword -AsPlainText -Force

Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName $domainName `
-DomainNetbiosName $domainNetbiosName `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-SafeModeAdministratorPassword $recoverySecurePassword `
-Force:$true

Stop-Transcript

restart-computer -f