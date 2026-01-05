# https://nixos.org/manual/nixpkgs/stable/#sec-building-environment
{
  # Allow unfree packages - without this you will get an error
  allowUnfree = true;

  packageOverrides =
    pkgs: with pkgs; {
      myPackages = pkgs.buildEnv {
        name = "rmjhynes-packages";
        paths = [
          act
          argocd
          bat
          dig
          fastfetch
          figlet
          # fzf - installed explicitly with Ansible
          gh
          ghostty
          gnupg
          # git - installed explicitly with Ansible
          golangci-lint
          htop
          jq
          k3d
          k9s
          kubernetes-helm
          kubeseal
          lazydocker
          lazygit
          librewolf
          localsend
          mullvad-vpn
          neovim
          pinentry-tty
          podman
          pre-commit
          rclone
          ripgrep
          starship
          terraform
          tlrc
          tree
          tmux
          vim
          yq-go
          # zoxide - installed explicitly with Ansible
          # zsh - installed explicitly with Ansible
        ];
      };
    };
}
