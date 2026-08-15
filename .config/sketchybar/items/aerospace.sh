#!/bin/bash

# AeroSpace Workspace Items for SketchyBar
# Based on FelixKratz's dotfiles style

source "$CONFIG_DIR/colors.sh"

# Define all workspaces (matching aerospace config)
WORKSPACES="1 2 3 4 5 6 7 8 9 A B C D E F G I M N O P Q R S T U V W X Y Z"

for sid in $WORKSPACES; do
  sketchybar --add item space.$sid left \
             --subscribe space.$sid aerospace_workspace_change \
             --set space.$sid \
                   icon="$sid" \
                   icon.font="FiraCode Nerd Font Mono:Bold:13.0" \
                   icon.padding_left=10 \
                   icon.padding_right=4 \
                   icon.color=$WORKSPACE_INACTIVE_FG \
                   icon.highlight_color=$WORKSPACE_ACTIVE_FG \
                   label.font="sketchybar-app-font:Regular:14.0" \
                   label.color=$LABEL_COLOR \
                   label.highlight_color=$WORKSPACE_ACTIVE_FG \
                   label.padding_right=16 \
                   label.y_offset=-1 \
                   padding_left=2 \
                   padding_right=2 \
                   background.color=$BRACKET_COLOR \
                   background.border_color=$SUBTLE_COLOR \
                   background.border_width=1 \
                   background.corner_radius=5 \
                   background.height=22 \
                   background.drawing=off \
                   click_script="aerospace workspace $sid" \
                   script="$PLUGIN_DIR/aerospace.sh $sid"
done
