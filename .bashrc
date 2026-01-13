# Add Nix packages to PATH if they exist (only needed on Linux, not macOS)
# Without this, Nix packages won't be usable even if they're installed
if [[ -d $HOME/.nix-profile/bin ]]; then
  export PATH="$HOME/.nix-profile/bin:$PATH"
fi

eval "$(starship init bash)"

source ~/.aliases

# needed for gpg to work
export GPG_TTY=$(tty)

# k3s
export KUBECONFIG=~/.kube/config
