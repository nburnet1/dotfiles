#!/bin/bash

# Media Plugin
# Shows currently playing media (Music, Spotify, etc.)

source "$CONFIG_DIR/colors.sh"

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  APP="$(echo "$INFO" | jq -r '.app')"
  TITLE="$(echo "$INFO" | jq -r '.title')"
  ARTIST="$(echo "$INFO" | jq -r '.artist')"
  
  # Set icon based on app
  case "$APP" in
    "Spotify") ICON="" ;;
    "Music") ICON="" ;;
    *) ICON="" ;;
  esac
  
  if [ -n "$ARTIST" ]; then
    LABEL="$ARTIST - $TITLE"
  else
    LABEL="$TITLE"
  fi
  
  sketchybar --set $NAME \
    icon="$ICON" \
    label="$LABEL" \
    drawing=on
else
  sketchybar --set $NAME drawing=off
fi
