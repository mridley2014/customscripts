# Install Visual Studio Code (VSCode)
$vscodeInstallerUrl = "https://update.code.visualstudio.com/latest/win32-x64-user/stable"
$vscodeInstallerPath = "$env:TEMP\VSCodeSetup.exe"

Invoke-WebRequest -Uri $vscodeInstallerUrl -OutFile $vscodeInstallerPath -UseBasicParsing
Start-Process -Wait -FilePath $vscodeInstallerPath -ArgumentList "/VERYSILENT /NORESTART"

# Install Git
$gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.1/Git-2.33.0-64-bit.exe"
$gitInstallerPath = "$env:TEMP\GitInstaller.exe"

Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath -UseBasicParsing
Start-Process -Wait -FilePath $gitInstallerPath -ArgumentList "/SILENT /NORESTART"

# Install Terraform
$terraformZipUrl = "https://releases.hashicorp.com/terraform/1.0.2/terraform_1.0.2_windows_amd64.zip"
$terraformZipPath = "$env:TEMP\terraform.zip"
$terraformInstallDir = "C:\Terraform"

Invoke-WebRequest -Uri $terraformZipUrl -OutFile $terraformZipPath -UseBasicParsing
Expand-Archive -Path $terraformZipPath -DestinationPath $terraformInstallDir -Force

# Add Terraform executable to PATH
[Environment]::SetEnvironmentVariable("Path", "$($env:Path);$terraformInstallDir", [EnvironmentVariableTarget]::Machine)

# Clean up temporary files
Remove-Item -Path $vscodeInstallerPath -Force
Remove-Item -Path $gitInstallerPath -Force
Remove-Item -Path $terraformZipPath -Force

Write-Host "Visual Studio Code, Git, and Terraform have been installed."
