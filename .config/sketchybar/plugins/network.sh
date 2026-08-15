#!/bin/bash

# Network Plugin
# Shows combined network activity

source "$CONFIG_DIR/colors.sh"

CACHE_FILE="/tmp/sketchybar_network_cache"

# Get current bytes
INTERFACE="en0"
CURRENT=$(netstat -ib | grep -E "^$INTERFACE" | head -1 | awk '{print $7, $10}')
CURRENT_DOWN=$(echo $CURRENT | awk '{print $1}')
CURRENT_UP=$(echo $CURRENT | awk '{print $2}')

# Read previous values
if [ -f "$CACHE_FILE" ]; then
  PREV=$(cat "$CACHE_FILE")
  PREV_DOWN=$(echo $PREV | awk '{print $1}')
  PREV_UP=$(echo $PREV | awk '{print $2}')
else
  PREV_DOWN=$CURRENT_DOWN
  PREV_UP=$CURRENT_UP
fi

# Save current values
echo "$CURRENT_DOWN $CURRENT_UP" > "$CACHE_FILE"

# Calculate bytes per second
DOWN_DIFF=$(( (CURRENT_DOWN - PREV_DOWN) / 2 ))
UP_DIFF=$(( (CURRENT_UP - PREV_UP) / 2 ))
TOTAL_DIFF=$((DOWN_DIFF + UP_DIFF))

# Handle negative
if [ $TOTAL_DIFF -lt 0 ]; then TOTAL_DIFF=0; fi

# Normalize (5MB/s = 1.0)
MAX_BYTES=5000000
NORM=$(echo "scale=4; $TOTAL_DIFF / $MAX_BYTES" | bc 2>/dev/null || echo "0")

# Cap at 1.0
if (( $(echo "$NORM > 1" | bc -l 2>/dev/null || echo 0) )); then NORM="1.0"; fi

# Push to graph
sketchybar --push network $NORM
