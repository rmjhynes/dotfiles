#!/bin/bash

# Create directory where nix packages file will live
mkdir ~/.config/nixpkgs

# Symlink config.nix file
ln -sfv $PWD/config.nix ~/.config/nixpkgs/config.nix

# Install packages declared in config.nix (temporarily allow unfree during
# install)
NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.myPackages
