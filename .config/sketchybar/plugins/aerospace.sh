#!/bin/bash

# AeroSpace Workspace Plugin
# Shows workspace with app icons (up to 3) using sketchybar-app-font

source "$CONFIG_DIR/colors.sh"

# Get the workspace ID passed as argument
WORKSPACE_ID="$1"

# Get currently focused workspace
if [ -n "$FOCUSED_WORKSPACE" ]; then
  CURRENT_WORKSPACE="$FOCUSED_WORKSPACE"
else
  CURRENT_WORKSPACE=$(aerospace list-workspaces --focused 2>/dev/null)
fi

# Get list of app names in this workspace (up to 3)
APPS=$(aerospace list-windows --workspace "$WORKSPACE_ID" --format '%{app-name}' 2>/dev/null | head -3)

# Build icon string using icon_map.sh
ICON_STRIP=""
if [ -n "$APPS" ]; then
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    icon=$("$CONFIG_DIR/plugins/icon_map.sh" "$app")
    ICON_STRIP+=" $icon"
  done <<< "$APPS"
fi

# Check if workspace has windows
HAS_WINDOWS=$([ -n "$APPS" ] && echo "true" || echo "false")

# Update workspace item
if [ "$WORKSPACE_ID" = "$CURRENT_WORKSPACE" ]; then
  # Focused workspace - prominent highlight with filled background
  sketchybar --set $NAME \
    drawing=on \
    icon.highlight=on \
    label.highlight=on \
    label="$ICON_STRIP" \
    background.drawing=on \
    background.color=$WORKSPACE_ACTIVE_BG \
    background.border_color=$WORKSPACE_ACTIVE_BG \
    background.border_width=2
  
elif [ "$HAS_WINDOWS" = "true" ]; then
  # Has windows but not focused - show normally
  sketchybar --set $NAME \
    drawing=on \
    icon.highlight=off \
    label.highlight=off \
    label="$ICON_STRIP" \
    background.drawing=on \
    background.color=0x00000000 \
    background.border_color=$SUBTLE_COLOR \
    background.border_width=1
else
  # Empty and not focused - hide it
  sketchybar --set $NAME drawing=off
fi
