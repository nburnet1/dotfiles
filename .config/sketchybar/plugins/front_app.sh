#!/bin/bash

# Front App Plugin
# Shows the currently focused application with its native icon

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME \
    label="$INFO" \
    background.image="app.$INFO"
fi
