#!/bin/bash

# Create directory where nix packages file will live
mkdir ~/.config/nixpkgs

# Symlink config.nix file
ln -sfv $PWD/config.nix ~/.config/nixpkgs/config.nix

# Install packages declared in config.nix
nix-env -iA nixpkgs.myPackages
