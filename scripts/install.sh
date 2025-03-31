#!/bin/zsh

# Remove files in home directory so they can be be replaced with symlinks
rm -rf ~/.zshrc ~/.p10k.zsh ~/.aliases ~/.vimrc ~/.tmux.conf ~/.config/ghostty/config ~/.config/htop/htoprc ~/.config/nvim ~/.config/gh/config.yml

# Create symlinks for files in home directory to point to cloned dotfiles directory
echo "Creating symlinks for files in the home directory to point to ~/dotfiles..."

# Symlink .zshrc file
ln -sfv ~/dotfiles/.zshrc ~/.zshrc

# Symlinklink .p10k.zsh
ln -sfv ~/dotfiles/.p10k.zsh ~/.p10k.zsh

# Symlink .aliases
ln -sfv ~/dotfiles/.aliases ~/.aliases

# Symlink .vimrc
ln -sfv ~/dotfiles/.vimrc ~/.vimrc

# Symlink .tmux.conf
ln -sfv ~/dotfiles/.tmux.conf ~/.tmux.conf

# Symlink ghostty config file
ln -sfv ~/dotfiles/ghostty.conf ~/.config/ghostty/config

# Symlink htoprc config file
ln -sfv ~/dotfiles/htoprc ~/.config/htop/htoprc

# Symlink gh config file
ln -sfv ~/dotfiles/gh-config.yml ~/.config/gh/config.yml

# Create symlinks for all files in nvim directory in script nvim_symlinks.sh
zsh ./scripts/nvim_symlinks.sh

echo "Symlinks created."

# Install Oh My Zsh if not already installed
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
# After installing oh-my-zsh, it backs up my .zshrc file to .zshrc.pre-oh-my-zsh and replaces it with
# a template file. Obviously I don't want this so I need to remove it and rename the backup file.
if [[ -f ~/.zshrc.pre-oh-my-zsh ]]; then
  echo "Removing stupid .zshrc template file generated by oh-my-zsh - using my .zshrc instead..."
  rm ~/.zshrc
  mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi
# Oh-my-zsh brings up a new shell here with the applied config, to continue the script, simply run 
# "exit"

# Install Powerlevel10k theme for ZSH if not already installed
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
if [[ ! -d $ZSH_CUSTOM/themes/powerlevel10k ]]; then
  echo "Installing Powerlevel10k theme..."
  git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install zsh-autosuggestions plugin if not already installed
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-autosuggestions ]]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin if not already installed
if [[ ! -d $ZSH_CUSTOM/plugins/zsh-syntax-highlighting ]]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Configure Dracula theme for vim if not already installed
echo "Setting up Dracula theme for vim..."
mkdir -p ~/.vim/pack/themes/start
if [[ ! -d ~/.vim/pack/themes/start/dracula ]]; then
  git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
fi

# Install tmux package manager if not already installed
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  echo "Installing TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
