#!/bin/bash

if pgrep -x wf-recorder >/dev/null;
then
  pkill --signal SIGINT wf-recorder
  notify-send "Stopped Recording"
else
  notify-send "Starting Recording"
  wf-recorder -f $(xdg-user-dir VIDEOS)/$(date +'recording_%Y-%m-%d-%H%M%S.mp4');
fi;
