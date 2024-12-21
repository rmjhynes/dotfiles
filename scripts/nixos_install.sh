#!/bin/zsh

NIX_HOME_DIRECTORY="/home/rmjhynes"
# Install Oh My Zsh if not already installed
if [[ ! -d $NIX_HOME_DIRECTORY/.oh-my-zsh ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Powerlevel10k theme for ZSH if not already installed
ZSH_CUSTOM=${ZSH_CUSTOM:-$NIX_HOME_DIRECTORY/.oh-my-zsh/custom}
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
mkdir -p $NIX_HOME_DIRECTORY/.vim/pack/themes/start
if [[ ! -d $NIX_HOME_DIRECTORY/.vim/pack/themes/start ]]; then
  git clone https://github.com/dracula/vim.git $NIX_HOME_DIRECTORY/.vim/pack/themes/start/dracula
fi

# Install tmux package manager if not already installed
if [[ ! -d $NIX_HOME_DIRECTORY/.tmux/plugins/tpm ]]; then
  echo "Installing TPM (tmux plugin manager)..."
  git clone https://github.com/tmux-plugins/tpm $NIX_HOME_DIRECTORY/.tmux/plugins/tpm
fi

# Source updates to TPM in tmux configuration file and reload
if command -v tmux &>/dev/null; then
  echo "Reloading tmux configuration..."
  # Start a detachched tmux session for config reload
  tmux new-session -d -s temp
  # Then can source the tmux config file
  tmux source-file $NIX_HOME_DIRECTORY/.tmux.conf
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
source $NIX_HOME_DIRECTORY/.zshrc

echo "Dotfiles installation and configuration complete."