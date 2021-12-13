#!/bin/bash

dir=$(xdg-user-dir VIDEOS)/Aufnahmen

[ -d $dir ] || mkdir -p $dir

file=$dir/$(date +'recording_%Y-%m-%d-%H%M%S.mp4')

echo $file

if [ -z $(pgrep wf-recorder) ]
then
  # do not disturb
  pkill --signal SIGINT mako
  if [ "$1" == "-s" ]
  then
    notify-send "Record Selection"
    wf-recorder -f $file -a -g "$(slurp -c "#FFFFFF")" &
    while [ ! -z $(pgrep -x slurp) ]; do wait; done
  elif [ "$1" == "-w" ]
  then
    notify-send "Record Window"
    wf-recorder -f $file -a -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -c "#FFFFFF" )" &
    while [ ! -z $(pgrep -x slurp) ]; do wait; done
  else
    wf-recorder -f $file -a -g "$(swaymsg -t get_outputs | jq -r '.. | select(.active?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp -c "#FFFFFF" )"&
    while [ ! -z $(pgrep -x slurp) ]; do wait; done
  fi
else
    notify-send "Record Output"
  pkill --signal SIGINT wf-recorder
  while [ ! -z $(pgrep -x wf-recorder) ]; do wait; done
  notify-send "Recording Stopped"
  name=$(zenity --entry --text "Enter a filename")

  if [ -n $name ]
  then
    mv $(ls -d $(xdg-user-dir VIDEOS)/Aufnahmen/* -t | head -n1) $(xdg-user-dir VIDEOS)/Aufnahmen/$name.mp4
  fi
fi
