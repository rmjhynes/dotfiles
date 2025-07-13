{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "rmjhynes-packages";
        paths = [
          argocd
          bat
          bind
          fastfetch
          figlet
          fzf
          gh
          git
          golangci-lint
          htop
          jq
          k9s
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
        ];
      };
    };
}
