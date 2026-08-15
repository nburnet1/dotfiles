#!/bin/bash

# CPU Plugin
# Shows CPU usage percentage

source "$CONFIG_DIR/colors.sh"

# Get CPU usage
CPU="$(top -l 2 -n 0 | grep -E "^CPU" | tail -1 | awk '{print int($3 + $5)}')"

if [ -z "$CPU" ]; then
  CPU="0"
fi

# Set color based on CPU usage
if [ "$CPU" -gt 80 ]; then
  COLOR=$RED
elif [ "$CPU" -gt 60 ]; then
  COLOR=$ORANGE
elif [ "$CPU" -gt 40 ]; then
  COLOR=$YELLOW
else
  COLOR=$ACCENT_COLOR
fi

sketchybar --set $NAME \
  icon="󰻠" \
  icon.color=$COLOR \
  label="${CPU}%"
