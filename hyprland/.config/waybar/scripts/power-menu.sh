#!/usr/bin/env bash

config="$HOME/.config/rofi/power-menu.rasi"

actions=$(echo -e "  Lock\n  Shutdown\n  Reboot\n  Suspend\n  Hibernate\n󰞘  Logout")

# Display logout menu
selected_option=$(echo -e "$actions" | rofi -dmenu -i -config "${config}" || pkill -x rofi)

# Perform actions based on the selected option
case "$selected_option" in
*Lock)
  loginctl lock-session
  ;;
*Shutdown)
  hyprshutdown -t 'Shutting down...' --post-cmd 'systemctl poweroff'
  ;;
*Reboot)
  hyprshutdown -t 'Restarting...' --post-cmd 'systemctl reboot'
  systemctl reboot
  ;;
*Suspend)
  systemctl suspend
  ;;
*Hibernate)
  systemctl hibernate
  ;;
*Logout)
  hyprctl dispatch "hl.dsp.exit()"
  ;;
esac
