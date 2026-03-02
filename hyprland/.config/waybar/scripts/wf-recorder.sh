#!/bin/bash
# recorder-status.sh
# Used by waybar to show recording state and stop on click.

ACTION=$1

if [ "$ACTION" == "stop" ]; then
    pkill -SIGINT wf-recorder
    exit 0
fi

# Default: print status for waybar (JSON)
if pgrep -x wf-recorder > /dev/null; then
    echo '{"text": " REC", "tooltip": "Click to stop recording", "class": "recording"}'
else
    echo '{"text": "", "tooltip": "", "class": ""}'
fi
