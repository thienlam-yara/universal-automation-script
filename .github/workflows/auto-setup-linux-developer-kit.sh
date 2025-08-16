#!/bin/bash

set -e # Exit on error

echo "Starting setup script for Linux (Debian/Ubuntu)..."

# Update package lists
sudo apt-get update

# Install essential build tools
echo "Installing build-essential..."
sudo apt-get install -y build-essential curl file git

# Install NVM (Node Version Manager)
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    # Load NVM for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

    # Add NVM to shell profile for future sessions
    echo "Configuring NVM for new terminal sessions..."
    {
      echo ''
      echo '# NVM configuration'
      echo 'export NVM_DIR="$HOME/.nvm"'
      echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
      echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
    } >> "$HOME/.bashrc"
    # Assuming bash, add to .zshrc if using zsh
else
    echo "NVM is already installed."
fi

# Install Docker
echo "Installing Docker..."
if ! command -v docker &> /dev/null; then
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker ${USER}
else
    echo "Docker is already installed."
fi

# Install Google Chrome
echo "Installing Google Chrome..."
if ! command -v google-chrome &> /dev/null; then
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt-get install -f -y # Fix dependencies
    rm google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome is already installed."
fi

# Install Android Studio (via snap)
echo "Installing Android Studio..."
if ! command -v android-studio &> /dev/null; then
    sudo snap install android-studio --classic
else
    echo "Android Studio is already installed."
fi

# Install OpenJDK
echo "Installing OpenJDK..."
sudo apt-get install -y default-jdk

# Install GitHub Desktop (via snap)
echo "Installing GitHub Desktop..."
if ! command -v github-desktop &> /dev/null; then
    sudo snap install github-desktop --classic
else
    echo "GitHub Desktop is already installed."
fi

# Install DBeaver Community Edition (via snap)
echo "Installing DBeaver Community Edition..."
if ! command -v dbeaver-community &> /dev/null; then
    sudo snap install dbeaver-ce
else
    echo "DBeaver is already installed."
fi

# Install Microsoft Teams
echo "Installing Microsoft Teams..."
if ! command -v teams &> /dev/null; then
    wget -O teams.deb "https://go.microsoft.com/fwlink/p/?LinkID=2112886"
    sudo dpkg -i teams.deb
    sudo apt-get install -f -y # Fix dependencies
    rm teams.deb
else
    echo "Microsoft Teams is already installed."
fi

# Install Cloudflare WARP
echo "Installing Cloudflare WARP..."
if ! command -v warp-cli &> /dev/null; then
    curl https://pkg.cloudflareclient.com/pubkey.gpg | sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
    sudo apt-get update
    sudo apt-get install -y cloudflare-warp
else
    echo "Cloudflare WARP is already installed."
fi

# Install libpq
echo "Installing libpq..."
sudo apt-get install -y libpq-dev

# Install zsh and Oh My Zsh
echo "Installing zsh and Oh My Zsh..."
sudo apt-get install -y zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# Install Cloud & DevOps Tools
echo "Installing Kubernetes, Helm, and AWS tools..."
sudo apt-get install -y kubectl
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
sudo apt-get install -y awscli

echo "Setup script completed."
