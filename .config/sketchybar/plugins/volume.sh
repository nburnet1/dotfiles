#!/bin/bash

# Volume Plugin
# Shows current volume level

source "$CONFIG_DIR/colors.sh"

VOLUME="$(osascript -e 'output volume of (get volume settings)')"
MUTED="$(osascript -e 'output muted of (get volume settings)')"

if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then
  ICON="󰝟"
  COLOR=$SUBTLE_COLOR
elif [ "$VOLUME" -gt 66 ]; then
  ICON="󰕾"
  COLOR=$ICON_COLOR
elif [ "$VOLUME" -gt 33 ]; then
  ICON="󰖀"
  COLOR=$ICON_COLOR
else
  ICON="󰕿"
  COLOR=$ICON_COLOR
fi

sketchybar --set $NAME \
  icon="$ICON" \
  icon.color=$COLOR \
  label="${VOLUME}%"
