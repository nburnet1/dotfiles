#!/bin/bash

# RAM Plugin
# Shows memory usage percentage

source "$CONFIG_DIR/colors.sh"

# Get memory stats
MEMORY=$(memory_pressure 2>/dev/null | grep "System-wide memory free percentage:" | awk '{print 100 - $5}' | cut -d'%' -f1)

# Fallback method if memory_pressure doesn't work
if [ -z "$MEMORY" ]; then
  MEMORY=$(top -l 1 -n 0 | grep PhysMem | awk '{print $2}' | sed 's/G//' | awk '{printf "%.0f", $1 / 16 * 100}')
fi

if [ -z "$MEMORY" ]; then
  MEMORY="0"
fi

# Set color based on RAM usage
if [ "$MEMORY" -gt 85 ]; then
  COLOR=$RED
elif [ "$MEMORY" -gt 70 ]; then
  COLOR=$ORANGE
elif [ "$MEMORY" -gt 50 ]; then
  COLOR=$YELLOW
else
  COLOR=$ACCENT_COLOR
fi

sketchybar --set $NAME \
  icon.color=$COLOR \
  label="${MEMORY}%"
