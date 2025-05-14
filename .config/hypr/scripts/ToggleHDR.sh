#!/bin/bash
# Script to toggle HDR off and back on to reset color management

notify-send "HDR Toggle" "Turning off HDR..."

# Disable HDR by setting color management to srgb
hyprctl keyword monitor "DP-3,2560x1440@165.08,0x790,1.0,bitdepth,10,cm,srgb"
hyprctl keyword monitor "HDMI-A-1,3840x2160@143.99,2560x0,1.0,bitdepth,10,cm,srgb"

# Wait for it to apply
sleep 2

notify-send "HDR Toggle" "Restoring HDR..."

# Re-enable HDR
hyprctl keyword monitor "DP-3,2560x1440@165.08,0x790,1.0,bitdepth,10,cm,hdr,sdrbrightness,1.2,sdrsaturation,1"
hyprctl keyword monitor "HDMI-A-1,3840x2160@143.99,2560x0,1.0,bitdepth,10,cm,hdr,sdrbrightness,1.2,sdrsaturation,1"

# Force DPMS cycle
hyprctl dispatch dpms off
sleep 1
hyprctl dispatch dpms on

notify-send "HDR Toggle" "HDR has been reset"

exit 0 