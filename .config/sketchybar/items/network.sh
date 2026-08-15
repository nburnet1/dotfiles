#!/bin/bash

# Network Card - FelixKratz style
# Layout: "NET" label top-right, speed below, dual graphs for up/down

source "$CONFIG_DIR/colors.sh"

# Label "NET" - small, top-right of graph area
net_top=(
  label.font="FiraCode Nerd Font Mono:Bold:7"
  label="NET"
  icon.drawing=off
  width=0
  padding_left=6
  padding_right=15
  y_offset=6
  label.color=$SUBTLE_COLOR
)

# Speed display - shows current up/down
net_speed=(
  label.font="FiraCode Nerd Font Mono:Bold:10"
  label="0B/s"
  y_offset=-4
  padding_right=15
  width=65
  icon.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/network_speed.sh"
)

# Download graph (background) - uses green
net_down=(
  width=0
  graph.color=$GREEN
  graph.fill_color=0x302e9ea9
  graph.line_width=1
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=off
  y_offset=2
)

# Upload graph (foreground) - uses accent/orange
net_up=(
  graph.color=$ORANGE
  graph.fill_color=0x30a37926
  graph.line_width=1
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=off
  padding_right=6
  y_offset=2
)

sketchybar --add item net.top right              \
           --set net.top "${net_top[@]}"         \
                                                 \
           --add item net.speed right            \
           --set net.speed "${net_speed[@]}"     \
                                                 \
           --add graph net.down right 75         \
           --set net.down "${net_down[@]}"       \
                                                 \
           --add graph net.up right 75           \
           --set net.up "${net_up[@]}"
