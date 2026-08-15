#!/bin/bash

# Battery Plugin
# Shows battery percentage and charging status

source "$CONFIG_DIR/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# Set icon and color based on battery level and charging state
if [ -n "$CHARGING" ]; then
  ICON="󰂄"
  COLOR=$GREEN
elif [ "$PERCENTAGE" -gt 80 ]; then
  ICON="󰁹"
  COLOR=$GREEN
elif [ "$PERCENTAGE" -gt 60 ]; then
  ICON="󰂀"
  COLOR=$ICON_COLOR
elif [ "$PERCENTAGE" -gt 40 ]; then
  ICON="󰁾"
  COLOR=$YELLOW
elif [ "$PERCENTAGE" -gt 20 ]; then
  ICON="󰁻"
  COLOR=$ORANGE
else
  ICON="󰂃"
  COLOR=$RED
fi

sketchybar --set $NAME \
  icon="$ICON" \
  icon.color=$COLOR \
  label="${PERCENTAGE}%"
