# https://nixos.org/manual/nixpkgs/stable/#sec-building-environment
{
  # Allow unfree packages - without this you will get an error
  allowUnfree = true;

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
          pay-respects # Alternative to thefuck which is no longer maintained
          pre-commit
          rclone
          ripgrep
          starship
          terraform
          tlrc
          tree
          tmux
          vim
        ];
      };
    };
}
