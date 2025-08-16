#Requires -RunAsAdministrator

# Set-ExecutionPolicy Bypass -Scope Process -Force;

Write-Host "Starting setup script for Windows..."

# Install Chocolatey if not already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Update Chocolatey
# choco upgrade chocolatey -y

# Install Git
Write-Host "Installing Git..."
choco install git -y --params "'/GitAndUnixToolsOnPath /NoAutoCrlf'"

# Install NVM for Windows
Write-Host "Installing NVM for Windows..."
if (-not (Get-Command nvm -ErrorAction SilentlyContinue)) {
    choco install nvm -y
    # Reload environment variables
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
    Write-Host "NVM for Windows is already installed."
}


# Install Docker Desktop
Write-Host "Installing Docker Desktop..."
choco install docker-desktop -y

# Install Google Chrome
Write-Host "Installing Google Chrome..."
choco install googlechrome -y

# Install Android Studio
Write-Host "Installing Android Studio..."
choco install androidstudio -y

# Install OpenJDK
Write-Host "Installing OpenJDK..."
choco install openjdk -y

# Install GitHub Desktop
Write-Host "Installing GitHub Desktop..."
choco install github-desktop -y

# Install DBeaver
Write-Host "Installing DBeaver..."
choco install dbeaver -y

# Install Microsoft Teams
Write-Host "Installing Microsoft Teams..."
choco install teams -y

# Install Cloudflare WARP
Write-Host "Installing Cloudflare WARP..."
choco install cloudflare-warp -y

# Install PostgreSQL (includes libpq)
Write-Host "Installing PostgreSQL..."
choco install postgresql -y

# Install Kubernetes, Helm, and AWS tools
Write-Host "Installing Kubernetes, Helm, and AWS tools..."
choco install kubernetes-cli -y
choco install kubernetes-helm -y
choco install awscli -y

Write-Host "Setup script completed."
