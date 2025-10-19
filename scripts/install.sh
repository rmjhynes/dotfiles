#!/bin/zsh

# Remove files in home directory so they can be be replaced with symlinks
rm -rf ~/.zshrc ~/.aliases ~/.vimrc ~/.tmux.conf ~/.config/ghostty/config ~/.config/htop/htoprc ~/.config/nvim ~/.config/gh/config.yml

# Create symlinks for files in home directory to point to cloned dotfiles directory
echo "Creating symlinks for files in the home directory to point to ~/dotfiles..."

# Symlink .zshrc file
ln -sfv ~/dotfiles/.zshrc ~/.zshrc

# Symlink .aliases
ln -sfv ~/dotfiles/.aliases ~/.aliases

# Symlink .vimrc
ln -sfv ~/dotfiles/.vimrc ~/.vimrc

# Symlink .tmux.conf
ln -sfv ~/dotfiles/.tmux.conf ~/.tmux.conf

# Create directory if it doesn't exist, then symlink ghostty config file
mkdir -p ~/.config/ghostty && ln -sfv ~/dotfiles/ghostty.conf ~/.config/ghostty/config

# Create directory if it doesn't exist, then symlink htoprc config file
mkdir -p ~/.config/htop && ln -sfv ~/dotfiles/htoprc ~/.config/htop/htoprc

# Create directory if it doesn't exist, then symlink gh config file
mkdir -p ~/.config/gh && ln -sfv ~/dotfiles/gh-config.yml ~/.config/gh/config.yml

# Create symlinks for all files in nvim directory in script nvim_symlinks.sh
zsh ./scripts/nvim_symlinks.sh

echo "Symlinks created."

# Install zsh-autosuggestions plugin if not already installed
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://rmjhynes@github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin if not already installed
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://rmjhynes@github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Configure Dracula theme for vim if not already installed
echo "Setting up Dracula theme for vim..."
mkdir -p ~/.vim/pack/themes/start
if [[ ! -d ~/.vim/pack/themes/start/dracula ]]; then
  git clone https://rmjhynes@github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
fi

# Install tmux package manager if not already installed
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "Installing TPM (tmux plugin manager)..."
  git clone https://rmjhynes@github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Source updates to TPM in tmux configuration file and reload
if command -v tmux &>/dev/null; then
  echo "Reloading tmux configuration..."
  # Start a detachched tmux session for config reload
  tmux new-session -d -s temp
  # Then can source the tmux config file
  tmux source-file ~/.tmux.conf
  # Note - manually refresh tmux after attaching to a session with:
  # prefix, shift + i

  # Detach from tmux session to continue script
  tmux detach -s temp

  # Kill the temporary session to clean up
  tmux kill-session -t temp
else
  echo "tmux not installed; skipping tmux configuration reload."
fi

# Apply zsh config
source ~/.zshrc

echo "Dotfiles installation and configuration complete."
