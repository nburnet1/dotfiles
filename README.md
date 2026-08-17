# Dotfiles

My macOS configuration for a tiling window manager setup with a custom status bar.

## Components

- **AeroSpace** - Tiling window manager (i3-like)
- **Sketchybar** - Custom status bar
- **Theme** - Dark Bulwer (inspired by James Bulwer paintings)

## Features

### Sketchybar
- Front app with native icon
- AeroSpace workspace integration with app icons
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

Install [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) for workspace app icons:
```bash
git clone https://github.com/kvndrsslr/sketchybar-app-font.git
cd sketchybar-app-font
pnpm install && pnpm run build:install
```

## Installation

```bash
git clone https://github.com/nburnet1/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Theme

Dark version of the [Bulwer Omarchy Theme](https://github.com/mattbbia/bulwer-omarchy) by [@mattbbia](https://github.com/mattbbia).

Color palette inspired by the landscapes of James Bulwer (1794–1879), adapted for dark mode.

### Wallpaper

Darkened version of "Landscape by the Shore with Road in Foreground" by James Bulwer.

Set wallpaper:
```bash
osascript -e 'tell application "System Events" to tell every desktop to set picture to "$HOME/Pictures/Wallpapers/bulwer-landscape-dark4.jpg"'
```

## Credits

- [FelixKratz/SketchyBar](https://github.com/FelixKratz/SketchyBar) - Status bar
- [FelixKratz/dotfiles](https://github.com/FelixKratz/dotfiles) - Sketchybar config inspiration
- [nikitabobko/AeroSpace](https://github.com/nikitabobko/AeroSpace) - Window manager
- [kvndrsslr/sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) - App icon font
- [mattbbia/bulwer-omarchy](https://github.com/mattbbia/bulwer-omarchy) - Color scheme inspiration
