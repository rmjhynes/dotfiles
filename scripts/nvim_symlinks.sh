#!/bin/zsh

# Recursively create symlinks for all files and directories in ~/dotfiles/nvim to point to $HOME directory

# Configuration
DOTFILES_NVIM_DIR="$HOME/dotfiles/nvim"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Create fresh nvim config directory
mkdir -p "$NVIM_CONFIG_DIR"

# Create symlinks for all files and directories
cd "$DOTFILES_NVIM_DIR" || exit
for item in $(find . -mindepth 1); do
  # Remove the leading ./
  item_path=${item#./}
  # Create parent directories if needed
  if [ -d "$DOTFILES_NVIM_DIR/$item_path" ]; then
    mkdir -p "$NVIM_CONFIG_DIR/$item_path"
  else
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR/$item_path")"
    # Create symlink pointing to ~/dotfiles
    ln -sfv "$DOTFILES_NVIM_DIR/$item_path" "$NVIM_CONFIG_DIR/$item_path"
  fi
done
