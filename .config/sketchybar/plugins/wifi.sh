#!/bin/bash

# WiFi Plugin
# Shows WiFi signal strength with animated icons

source "$CONFIG_DIR/colors.sh"

# Get WiFi info
WIFI_INFO=$(system_profiler SPAirPortDataType 2>/dev/null | grep -A 20 "Current Network")
SSID=$(echo "$WIFI_INFO" | awk -F': ' '/^[[:space:]]*[^:]+:$/{gsub(/^[[:space:]]+|:$/,""); print; exit}')
RSSI=$(echo "$WIFI_INFO" | grep "Signal / Noise" | awk -F': ' '{print $2}' | awk -F' ' '{print $1}')

# If no SSID from system_profiler, try ipconfig
if [ -z "$SSID" ]; then
  SSID=$(ipconfig getsummary en0 2>/dev/null | grep " SSID" | grep -v BSSID | awk -F': ' '{print $2}')
fi

if [ -z "$SSID" ]; then
  # Not connected
  ICON="󰤭"
  LABEL=""
  COLOR=$RED
else
  # Connected - determine signal strength
  # RSSI: -30 = amazing, -67 = good, -70 = okay, -80 = bad, -90 = unusable
  if [ -n "$RSSI" ]; then
    RSSI_NUM=${RSSI//-/}  # Remove negative sign for comparison
    if [ "$RSSI_NUM" -lt 50 ]; then
      ICON="󰤨"  # Full signal
      COLOR=$GREEN
    elif [ "$RSSI_NUM" -lt 60 ]; then
      ICON="󰤥"  # Good signal
      COLOR=$ACCENT_COLOR
    elif [ "$RSSI_NUM" -lt 70 ]; then
      ICON="󰤢"  # Medium signal
      COLOR=$YELLOW
    elif [ "$RSSI_NUM" -lt 80 ]; then
      ICON="󰤟"  # Low signal
      COLOR=$ORANGE
    else
      ICON="󰤯"  # Very low signal
      COLOR=$RED
    fi
  else
    ICON="󰤨"  # Default to full if can't get RSSI
    COLOR=$ACCENT_COLOR
  fi
  LABEL=""
fi

sketchybar --set $NAME \
  icon="$ICON" \
  icon.color=$COLOR \
  label="$LABEL"
