#!/bin/zsh

# Remove files in home directory so they can be be replaced with symlinks
rm -rf $HOME/.zshrc \
  $HOME/.bashrc \
  $HOME/.aliases \
  $HOME/.vimrc \
  $HOME/.tmux.conf \
  $XDG_CONFIG_HOME/ghostty/config \
  $XDG_CONFIG_HOME/htop/htoprc \
  $XDG_CONFIG_HOME/nvim \
  $XDG_CONFIG_HOME/gh/config.yml \
  $XDG_CONFIG_HOME/starship.toml

# Create symlinks for files in home directory to point to cloned dotfiles directory
echo "Creating symlinks for files in the home directory to point to $HOME/dotfiles..."

# Symlink .zshrc file
ln -sfv $HOME/dotfiles/.zshrc $HOME/.zshrc

# Symlink .bashrc file
ln -sfv $HOME/dotfiles/.bashrc $HOME/.bashrc

# Symlink .aliases
ln -sfv $HOME/dotfiles/.aliases $HOME/.aliases

# Symlink .vimrc
ln -sfv $HOME/dotfiles/.vimrc $HOME/.vimrc

# Symlink .tmux.conf
ln -sfv $HOME/dotfiles/.tmux.conf $HOME/.tmux.conf

# Symlink starship.toml
ln -sfv $HOME/dotfiles/starship.toml $XDG_CONFIG_HOME/starship.toml

# Create directory if it doesn't exist, then symlink ghostty config file
mkdir -p $XDG_CONFIG_HOME/ghostty && ln -sfv $HOME/dotfiles/ghostty.conf $XDG_CONFIG_HOME/ghostty/config

# Create directory if it doesn't exist, then symlink htoprc config file
mkdir -p $XDG_CONFIG_HOME/htop && ln -sfv $HOME/dotfiles/htoprc $XDG_CONFIG_HOME/htop/htoprc

# Create directory if it doesn't exist, then symlink gh config file
mkdir -p $XDG_CONFIG_HOME/gh && ln -sfv $HOME/dotfiles/gh-config.yml $XDG_CONFIG_HOME/gh/config.yml

# Create symlinks for all files in nvim directory in script nvim_symlinks.sh
zsh ./scripts/nvim_symlinks.sh

echo "Symlinks created."

# Install zsh-autosuggestions plugin if not already installed
if [[ ! -d $HOME/.zsh/zsh-autosuggestions ]]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://rmjhynes@github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
fi

# Configure Dracula theme for vim if not already installed
echo "Setting up Dracula theme for vim..."
mkdir -p $HOME/.vim/pack/themes/start
if [[ ! -d $HOME/.vim/pack/themes/start/dracula ]]; then
  git clone https://rmjhynes@github.com/dracula/vim.git $HOME/.vim/pack/themes/start/dracula
fi

# Install tmux package manager if not already installed
if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
  echo "Installing TPM (tmux plugin manager)..."
  git clone https://rmjhynes@github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Source updates to TPM in tmux configuration file and reload
if command -v tmux &>/dev/null; then
  echo "Reloading tmux configuration..."
  # Start a detachched tmux session for config reload
  tmux new-session -d -s temp
  # Then can source the tmux config file
  tmux source-file $HOME/.tmux.conf
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
source $HOME/.zshrc

echo "Dotfiles installation and configuration complete."
