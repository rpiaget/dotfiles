#!/usr/bin/env zsh

echo "\n--- Starting Homebrew Install ---\n"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# # Brew some brews
# brew install httpie
# brew install bat

# # Brew some casks
# brew install --cask --no-quarantine google-chrome
# brew install --cask --no-quarantine firefox
# brew install --cask --no-quarantine visual-studio-code
# brew install --cask --no-quarantine alfred

brew bundle --verbose
