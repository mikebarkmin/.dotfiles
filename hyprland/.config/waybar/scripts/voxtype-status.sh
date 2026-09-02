#!/bin/bash
# voxtype-status.sh
# Used by waybar to show dictation state and toggle on click.

ACTION=$1

if [ "$ACTION" == "toggle" ]; then
    if pgrep -x voxtype > /dev/null; then
        voxtype record stop
    else
        voxtype record start
    fi
    exit 0
fi

# Default: print status for waybar (JSON)
if pgrep -x voxtype > /dev/null; then
    echo '{"text": " 󰰭 ", "tooltip": "Click to stop dictation", "class": "dictating"}'
else
    echo '{"text": " 󰰮 ", "tooltip": "Click to start dictation", "class": ""}'
fi