{
  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "my-packages";
        paths = [
          # CLI
          vim
          neovim
          tmux
          bat
          fzf
          htop
          thefuck
          tlrc
          neofetch
          k9s
          jq
          yq-go
          lazygit
          zoxide

          # Languages
          python314
          go
          terraform

          # Infra
          k3s
          argocd
          kubernetes-helm
          rclone
          kubeseal

          # Networking
          dig
        ];
      };
    };
}
