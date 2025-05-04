#!/bin/bash

# Create directory where nix packages file will live
mkdir ~/.config/nixpkgs

# Symlink config.nix file
ln -sfv ~/.config/nixpkgs/config.nix ~/config.nix

# Install packages declared in config.nix
nix-env -iA nixpkgs.myPackages
