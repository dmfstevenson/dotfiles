#!/bin/bash
# Script to fix monitor issues after resume from suspend

# Wait for monitors to initialize
sleep 2

# Call the HDR toggle script to do a complete reset
$HOME/.config/hypr/scripts/ToggleHDR.sh

# For good measure, perform a full Hyprland reload
sleep 1
hyprctl reload

exit 0 