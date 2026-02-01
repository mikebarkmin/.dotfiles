#!/bin/bash

STATUS_CONNECTED="Connected"

pangolin_status() {
  status="$(pangolin status 2>/dev/null | awk 'NR==2 {print $4}')"
  if [ "$status" = "$STATUS_CONNECTED" ]; then
    return 0
  fi
  return 1
}

toggle_status() {
  if pangolin_status; then
    pangolin down
  else
    pangolin up
  fi
  sleep 5
}

case $1 in
--status)
  if pangolin_status; then
    # Get org name from status output
    org=$(pangolin status 2>/dev/null | awk 'NR==2 {print $5}')
    version=$(pangolin status 2>/dev/null | awk 'NR==2 {print $3}')
    
    echo "{\"text\":\"${org}\",\"class\":\"connected\",\"alt\":\"connected\", \"tooltip\": \"Pangolin ${version}\\nOrg: ${org}\"}"
  else
    echo "{\"text\":\"\",\"class\":\"stopped\",\"alt\":\"stopped\", \"tooltip\": \"Pangolin is not connected.\"}"
  fi
  ;;
--toggle)
  toggle_status
  ;;
esac
