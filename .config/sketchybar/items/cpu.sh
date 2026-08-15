#!/bin/bash

# CPU Card - FelixKratz style
# Layout: "CPU" label top-right, percentage below, system graph

source "$CONFIG_DIR/colors.sh"

# Label "CPU" - small, top-right of graph area
cpu_top=(
  label.font="FiraCode Nerd Font Mono:Bold:7"
  label="CPU"
  icon.drawing=off
  width=0
  padding_left=6
  padding_right=15
  y_offset=6
  label.color=$SUBTLE_COLOR
)

# Percentage - larger, below the label
cpu_percent=(
  label.font="FiraCode Nerd Font Mono:Bold:12"
  label="0%"
  y_offset=-4
  padding_right=15
  width=55
  icon.drawing=off
  update_freq=2
  script="$PLUGIN_DIR/cpu_percent.sh"
)

# System CPU graph - uses accent color
cpu_sys=(
  graph.color=$ACCENT_COLOR
  graph.fill_color=0x30bc8400
  graph.line_width=1
  label.drawing=off
  icon.drawing=off
  background.height=26
  background.drawing=off
  padding_left=0
  padding_right=6
  y_offset=2
)

sketchybar --add item cpu.top right              \
           --set cpu.top "${cpu_top[@]}"         \
                                                 \
           --add item cpu.percent right          \
           --set cpu.percent "${cpu_percent[@]}" \
                                                 \
           --add graph cpu.sys right 75          \
           --set cpu.sys "${cpu_sys[@]}"
