#!/bin/bash

HOTSPOT_NAME="Hotspot"

is_active() {
  nmcli -t -f NAME,STATE connection show --active | grep -q "^${HOTSPOT_NAME}:activated$"
}

get_iface() {
  nmcli -t -f NAME,DEVICE connection show --active | grep "^${HOTSPOT_NAME}:" | cut -d: -f2
}

get_clients_tooltip() {
  local iface="$1"
  local lines=""
  local ips=""

  while IFS= read -r mac; do
    [ -z "$mac" ] && continue
    ip=$(ip neigh show dev "$iface" 2>/dev/null | grep -i "$mac" | grep -v "fe80:" | head -1 | awk '{print $1}')
    if [ -n "$ip" ]; then
      if [ -z "$ips" ]; then
        ips="${ip}"
      else
        ips="${ips}, ${ip}"
      fi
    fi
  done < <(iw dev "$iface" station dump 2>/dev/null | grep "^Station" | awk '{print $2}')

  if [ -z "$ips" ]; then
    printf "No clients connected"
  else
    printf "Connected clients:\n• %s" "$ips"
  fi
}

case $1 in
--status)
  if is_active; then
    iface=$(get_iface)
    tooltip=$(get_clients_tooltip "$iface" | sed ':a;N;$!ba;s/\n/\\n/g')
    echo "{\"text\":\"󱛁\",\"class\":\"active\",\"alt\":\"active\",\"tooltip\":\"Device: ${iface}\\n${tooltip}\"}"
  else
    iface=$(get_iface)
    if [ -z "$iface" ]; then
      echo "{\"text\":\"󱛃\",\"class\":\"inactive\",\"alt\":\"inactive\",\"tooltip\":\"Hotspot off\"}"
    else
      echo "{\"text\":\"󱛃\",\"class\":\"inactive\",\"alt\":\"inactive\",\"tooltip\":\"Device: ${iface}\nHotspot off\"}"
    fi
  fi
  ;;
--toggle)
  if is_active; then
    nmcli connection down "$HOTSPOT_NAME"
  else
    nmcli connection up "$HOTSPOT_NAME"
  fi
  ;;
esac
