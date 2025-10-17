#!/bin/bash

# If using MacOS
if [ $(uname) = 'Darwin' ]; then
  export ZSH="$HOME/.oh-my-zsh"

  # If not already installed, install Homebrew
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install packages listed in the Brewfile
  if [[ -f ~/dotfiles/Brewfile ]]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file=~/dotfiles/Brewfile
    brew upgrade
  else
    echo "Brewfile not found in ~/dotfiles."
    exit 1
  fi

  # Install LibreWolf without quarantine otherwise you get 'LibreWolf is damaged and can't be opened...' error.
  brew reinstall librewolf --cask --no-quarantine

# If using Linux (check /etc/os-release)
elif [ -f /etc/os-release ]; then
  # Find operating system ID value from /etc/os-release
  OS_ID="$(awk -F '=' '/^ID=/ {print $2}' /etc/os-release | tr -d '"')"

  # If using NixOS
  if [ "$OS_ID" = 'nixos' ]; then
    export ZSH="${NIX_HOME_DIRECTORY:-$HOME}/.oh-my-zsh"

  # Install packages with Nix package manager
  else
    export ZSH="$HOME/.oh-my-zsh"

    # Install packages with Nix package manager
    nix-env -iA nixpkgs.myPackages
  fi

# If not macOS or Linux with an expected OS
else
  echo "Unsupported / unknown operating system." >&2
  exit 1
fi

# Install dotfiles with zsh in script install.sh
zsh ./scripts/install.sh
