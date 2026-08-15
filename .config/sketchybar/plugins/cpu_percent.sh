#!/bin/bash

# CPU Plugin - FelixKratz style
# Updates percentage label and pushes to system graph
# Color changes based on load level

source "$CONFIG_DIR/colors.sh"

# Get CPU stats - total usage
CPU_INFO=$(top -l 2 -n 0 | grep -E "^CPU" | tail -1)
USER_CPU=$(echo "$CPU_INFO" | awk '{print $3}' | tr -d '%')
SYS_CPU=$(echo "$CPU_INFO" | awk '{print $5}' | tr -d '%')

# Handle empty values
if [ -z "$USER_CPU" ]; then USER_CPU="0"; fi
if [ -z "$SYS_CPU" ]; then SYS_CPU="0"; fi

# Calculate total and normalize for graph (0.0 - 1.0)
TOTAL=$((${USER_CPU%.*} + ${SYS_CPU%.*}))
TOTAL_NORM=$(echo "scale=2; $TOTAL / 100" | bc)

# Color based on load (with graph fill colors)
if [ "$TOTAL" -ge 80 ]; then
  COLOR=$RED
  GRAPH_COLOR=$RED
  FILL_COLOR=0x30936100
elif [ "$TOTAL" -ge 60 ]; then
  COLOR=$ORANGE
  GRAPH_COLOR=$ORANGE
  FILL_COLOR=0x30a37926
elif [ "$TOTAL" -ge 40 ]; then
  COLOR=$YELLOW
  GRAPH_COLOR=$YELLOW
  FILL_COLOR=0x30bc8400
else
  COLOR=$LABEL_COLOR
  GRAPH_COLOR=$ACCENT_COLOR
  FILL_COLOR=0x30bc8400
fi

# Update label, graph color, and push data
sketchybar --set cpu.percent label="${TOTAL}%" label.color=$COLOR \
           --set cpu.sys graph.color=$GRAPH_COLOR graph.fill_color=$FILL_COLOR \
           --push cpu.sys $TOTAL_NORM
