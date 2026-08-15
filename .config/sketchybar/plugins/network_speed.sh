#!/bin/bash

# Network Speed Plugin - FelixKratz style
# Updates speed label and pushes to dual graphs (up/down)

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

# Calculate bytes per second (update_freq=2)
DOWN_DIFF=$(( (CURRENT_DOWN - PREV_DOWN) / 2 ))
UP_DIFF=$(( (CURRENT_UP - PREV_UP) / 2 ))

# Handle negative/overflow
if [ $DOWN_DIFF -lt 0 ]; then DOWN_DIFF=0; fi
if [ $UP_DIFF -lt 0 ]; then UP_DIFF=0; fi

# Format speed (show higher of up/down)
format_speed() {
  local bytes=$1
  if [ $bytes -gt 1073741824 ]; then
    echo "$(echo "scale=1; $bytes/1073741824" | bc)G"
  elif [ $bytes -gt 1048576 ]; then
    echo "$(echo "scale=1; $bytes/1048576" | bc)M"
  elif [ $bytes -gt 1024 ]; then
    echo "$(echo "scale=0; $bytes/1024" | bc)K"
  else
    echo "${bytes}B"
  fi
}

# Display the higher speed
if [ $DOWN_DIFF -gt $UP_DIFF ]; then
  SPEED=$(format_speed $DOWN_DIFF)
  SPEED_LABEL="↓${SPEED}/s"
else
  SPEED=$(format_speed $UP_DIFF)
  SPEED_LABEL="↑${SPEED}/s"
fi

# Normalize for graphs (5MB/s = 1.0)
MAX_BYTES=5000000
DOWN_NORM=$(echo "scale=4; $DOWN_DIFF / $MAX_BYTES" | bc 2>/dev/null || echo "0")
UP_NORM=$(echo "scale=4; $UP_DIFF / $MAX_BYTES" | bc 2>/dev/null || echo "0")

# Cap at 1.0
cap_value() {
  local val=$1
  if (( $(echo "$val > 1" | bc -l 2>/dev/null || echo 0) )); then
    echo "1.0"
  else
    echo "$val"
  fi
}

DOWN_NORM=$(cap_value $DOWN_NORM)
UP_NORM=$(cap_value $UP_NORM)

# Update label and push to both graphs
sketchybar --set net.speed label="$SPEED_LABEL" \
           --push net.down $DOWN_NORM \
           --push net.up $UP_NORM
