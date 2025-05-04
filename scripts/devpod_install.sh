#!/bin/bash

# Symlink config.nix file
ln -sfv ~/.config/nixpkgs/config.nix ~/config.nix
# Install packages declared in config.nix
nix-env -iA nixpkgs.myPackages
