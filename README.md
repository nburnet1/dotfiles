# Dotfiles

My macOS configuration for a tiling window manager setup with a custom status bar.

## Components

- **AeroSpace** - Tiling window manager (i3-like)
- **Sketchybar** - Custom status bar
- **Theme** - Dark Bulwer (inspired by James Bulwer paintings)

## Features

### Sketchybar
- Front app with native icon
- AeroSpace workspace integration with app icons (sketchybar-app-font)
- System stats: CPU, RAM, Network, Battery, Volume, WiFi
- Media player widget
- Dark Bulwer color scheme

### AeroSpace
- Workspaces 1-9 and A-Z
- Sketchybar event integration for workspace changes

## Dependencies

```bash
brew install sketchybar
brew install --cask nikitabobko/tap/aerospace
brew install --cask font-fira-code-nerd-font
```

Install sketchybar-app-font:
```bash
git clone https://github.com/kvndrsslr/sketchybar-app-font.git
cd sketchybar-app-font
pnpm install && pnpm run build:install
```

## Installation

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Wallpaper

Dark version of "Landscape by the Shore with Road in Foreground" by James Bulwer.

Set wallpaper:
```bash
osascript -e 'tell application "System Events" to tell every desktop to set picture to "~/Pictures/Wallpapers/bulwer-landscape-dark4.jpg"'
```
