#!/bin/bash

# CPU Percent Plugin
# Shows CPU percentage with fixed width

source "$CONFIG_DIR/colors.sh"

# Get CPU usage
CPU=$(top -l 2 -n 0 | grep -E "^CPU" | tail -1 | awk '{print int($3 + $5)}')

if [ -z "$CPU" ]; then
  CPU="0"
fi

sketchybar --set cpu_percent label="${CPU}%"
