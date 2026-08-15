#!/bin/bash

# Dotfiles Install Script
# Links configs for sketchybar, aerospace, nvim, and wallpapers

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create symlinks for sketchybar
echo "Linking sketchybar config..."
rm -rf ~/.config/sketchybar
ln -sf "$DOTFILES_DIR/.config/sketchybar" ~/.config/sketchybar

# Create symlink for aerospace
echo "Linking aerospace config..."
ln -sf "$DOTFILES_DIR/.config/aerospace/aerospace.toml" ~/.aerospace.toml

# Create symlink for nvim (LazyVim)
echo "Linking nvim config..."
rm -rf ~/.config/nvim
ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim

# Copy wallpapers
echo "Copying wallpapers..."
mkdir -p ~/Pictures/Wallpapers
cp -n "$DOTFILES_DIR/wallpapers/"* ~/Pictures/Wallpapers/ 2>/dev/null || true

echo "Done! Restart services to apply changes:"
echo "  sketchybar --reload"
echo "  aerospace reload-config"
