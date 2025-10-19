# dotfiles
A repo to store my dot files.

## Installation
1. Clone the repo in your home directory.
2. Run `cd ~/dotfiles; bash scripts/setup.sh`.

## Issues
When installing Nix packages, ensure you don't have a package in `config.nix` that has already been installed manually with `nix-env -iA nixpkgs.<package>` otherwise you will get a conflict error. Since Nix is atomic, this error will mean **none** of the packages in `config.nix` are installed which may cause confusion when debugging.
