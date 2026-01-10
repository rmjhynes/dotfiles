#!/bin/bash

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Set XDG_CONFIG_HOME to ~/.config if it's not already set
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# If using MacOS
if [ $(uname) = 'Darwin' ]; then

  # If not already installed, install Homebrew
  if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install packages listed in the Brewfile
  if [[ -f $HOME/dotfiles/Brewfile ]]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file=$HOME/dotfiles/Brewfile
    brew upgrade
  else
    echo "Brewfile not found in ~/dotfiles."
    exit 1
  fi

  # Install LibreWolf without quarantine otherwise you get 'LibreWolf is damaged and can't be opened...' error.
  brew reinstall librewolf --cask --no-quarantine

  # Install DevPod CLI
  curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-darwin-arm64" && sudo install -c -m 0755 devpod /usr/local/bin && rm -f devpod

# If using Linux (check /etc/os-release)
elif [ -f /etc/os-release ]; then
  # Find operating system ID value from /etc/os-release
  #OS_ID="$(awk -F '=' '/^ID=/ {print $2}' /etc/os-release | tr -d '"')"

  # Create required Nix directory and install packages with Nix package manager
  mkdir -p $XDG_CONFIG_HOME/nixpkgs
  ln -sfv $HOME/dotfiles/config.nix $XDG_CONFIG_HOME/nixpkgs/config.nix
  nix-env -iA nixpkgs.myPackages

# If not macOS or Linux with an expected OS
else
  echo "Unsupported / unknown operating system." >&2
  exit 1
fi

# Install dotfiles with zsh in script install.sh
zsh "$SCRIPT_DIR/install.sh"
