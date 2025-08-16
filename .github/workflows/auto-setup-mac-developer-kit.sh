#!/bin/bash

set -e  # Exit on error

echo "Starting setup script..."

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Add Homebrew to PATH for the current session
    eval "$(/opt/homebrew/bin/brew shellenv)"  # Adjust if on Intel Mac: /usr/local/bin/brew
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
brew update

# Install Xcode Command Line Tools (full Xcode requires manual App Store installation, so using CLI tools)
if ! xcode-select -p &> /dev/null; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
    # Note: This may require user interaction in non-CI environments
else
    echo "Xcode Command Line Tools are already installed."
fi

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
    } >> "$HOME/.zshrc"
else
    echo "NVM is already installed."
fi

# Install OrbStack
echo "Installing OrbStack..."
brew install --cask orbstack || echo "OrbStack is already installed."

# Install Google Chrome
echo "Installing Google Chrome..."
brew install --cask google-chrome || echo "Google Chrome is already installed."

# Install Android Studio
echo "Installing Android Studio..."
brew install --cask android-studio || echo "Android Studio is already installed."

# Install JDK (using OpenJDK latest version)
echo "Installing OpenJDK..."
brew install openjdk || echo "OpenJDK is already installed."

# Install GitHub Desktop
echo "Installing GitHub Desktop..."
brew install --cask github || echo "GitHub Desktop is already installed."

# Install Flipper
echo "Installing Flipper..."
brew install --cask flipper || echo "Flipper is already installed."

# Install DBeaver Community Edition
echo "Installing DBeaver Community Edition..."
brew install --cask dbeaver-community || echo "DBeaver Community Edition is already installed."

# Install Studio 3T
echo "Installing Studio 3T..."
brew install --cask studio-3t || echo "Studio 3T is already installed."

# Install Microsoft Teams
echo "Installing Microsoft Teams..."
brew install --cask microsoft-teams || echo "Microsoft Teams is already installed."

# Install Cloudflare WARP
echo "Installing Cloudflare WARP..."
brew install --cask cloudflare-warp || echo "Cloudflare WARP is already installed."

# Install CocoaPods
echo "Installing CocoaPods..."
brew install cocoapods || echo "CocoaPods is already installed."

echo "Setup script completed."