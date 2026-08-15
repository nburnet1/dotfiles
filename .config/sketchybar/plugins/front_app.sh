#!/bin/bash

# Front App Plugin
# Shows the currently focused application with its native icon
# Hides icon for apps without proper macOS icons

if [ "$SENDER" = "front_app_switched" ]; then
  # Apps that don't have proper macOS icons - hide the image
  case "$INFO" in
    "loginwindow"|""|"'localhost'"|"localhost")
      sketchybar --set $NAME \
        label="$INFO" \
        background.image.drawing=off
      ;;
    *)
      sketchybar --set $NAME \
        label="$INFO" \
        background.image="app.$INFO" \
        background.image.drawing=on
      ;;
  esac
fi
