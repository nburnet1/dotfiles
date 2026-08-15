#!/bin/bash

# Update sketchybar colors from current wallpaper
# Usage: ./update_colors.sh [optional: /path/to/wallpaper.jpg]

WAL_PATH="$HOME/.local/bin/wal"

if [ -n "$1" ]; then
  # Use provided wallpaper
  WALLPAPER="$1"
else
  # Get current wallpaper
  WALLPAPER=$(osascript -e 'tell application "Finder" to get POSIX path of (get desktop picture as alias)' 2>/dev/null)
fi

if [ -z "$WALLPAPER" ]; then
  echo "Could not detect wallpaper"
  exit 1
fi

echo "Generating colors from: $WALLPAPER"

# Generate colors with pywal
$WAL_PATH -i "$WALLPAPER" -n -q

# Reload sketchybar
sketchybar --reload

echo "Done! Sketchybar colors updated."
