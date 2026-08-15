#!/bin/bash

# CPU Graph Plugin
# Pushes CPU usage to sparkline only

source "$CONFIG_DIR/colors.sh"

# Get CPU usage
CPU=$(top -l 2 -n 0 | grep -E "^CPU" | tail -1 | awk '{print int($3 + $5)}')

if [ -z "$CPU" ]; then
  CPU="0"
fi

# Normalize for graph (0.0 - 1.0)
CPU_NORM=$(echo "scale=2; $CPU / 100" | bc)

# Push to graph
sketchybar --push cpu_graph $CPU_NORM
