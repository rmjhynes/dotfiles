# Add Nix packages to PATH if they exist (only needed on Linux, not macOS)
# Without this, Nix packages won't be usable even if they're installed
if [[ -d $HOME/.nix-profile/bin ]]; then
  export PATH="$HOME/.nix-profile/bin:$PATH"
fi

# Setup starship
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Setup zoxide
eval "$(zoxide init zsh)"

# needed for gpg to work
export GPG_TTY=$(tty)

# Dracula theme for fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.aliases

# Claude code
export PATH="$HOME/.local/bin:$PATH"
