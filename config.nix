# https://nixos.org/manual/nixpkgs/stable/#sec-building-environment
{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "rmjhynes-packages";
        paths = [
          argocd
          bat
          dig
          fastfetch
          figlet
          fzf
          gh
          git
          golangci-lint
          htop
          jq
          k9s
          kubernetes-helm
          kubeseal
          lazydocker
          lazygit
          neovim
          pre-commit
          rclone
          ripgrep
          terraform
          thefuck
          tlrc
          tree
          tmux
          vim
          zoxide
          zsh
        ];
      };
    };
}
