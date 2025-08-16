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

echo "Setup script completed."