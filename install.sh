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

# Create symlinks for files in home directory to point to cloned dotfiles directory
echo "Creating symlinks for files in the home directory to point to ~/dotfiles..."

# Symlink .zshrc file
ln -sf ~/dotfiles/.zshrc ~/.zshrc

# Symlinklink .p10k.zsh
ln -sf ~/dotfiles/.p10k.zsh ~/.p10k.zsh

# Symlink .aliases
ln -sf ~/dotfiles/.aliases ~/.aliases

# Symlink .vimrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

# Symlink .tmux.conf
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Symlink files in nvim directory
for file in ~/dotfiles/nvim/*; do
  ln -sf "$file" ~/.config/nvim/$(basename "$file")
done

echo "Symlinks created."

# Install Oh My Zsh if not already installed
if [[ ! -d ~/.oh-my-zsh ]]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

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
  tmux source-file ~/.tmux.conf
  # Then manually refresh tmux after attaching to a session with:
  # prefix, shift + i
else
  echo "tmux not installed; skipping tmux configuration reload."
fi

# Apply zsh config
source ~/.zshrc

echo "Dotfiles installation and configuration complete."
