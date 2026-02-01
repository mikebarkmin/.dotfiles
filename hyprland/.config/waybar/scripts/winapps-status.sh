#!/bin/bash

COMPOSE_DIR="/home/mike/.local/bin/winapps-src"
COMPOSE_FILE="$COMPOSE_DIR/compose.yaml"

# Check if compose file exists
if [ ! -f "$COMPOSE_FILE" ]; then
  echo '{"text": "󰖳", "class": "missing", "tooltip": "WinApps compose.yaml not found"}'
  exit 1
fi

# Change to the compose directory and check status
cd "$COMPOSE_DIR" || exit 1

# Get the status of the compose services
if podman-compose ps -q >/dev/null 2>&1; then
  # Check if any containers are running
  RUNNING_CONTAINERS=$(podman-compose ps --format "table {{.Names}}\t{{.Status}}" 2>/dev/null | grep -c "Up" || echo "0")

  if [ "$RUNNING_CONTAINERS" -gt 0 ]; then
    echo '{"text": "󰖳", "class": "running", "tooltip": "WinApps containers running ('"$RUNNING_CONTAINERS"'/'"$TOTAL_CONTAINERS"')"}'
  else
    echo '{"text": "󰖳", "class": "stopped", "tooltip": "WinApps containers stopped"}'
  fi
else
  echo '{"text": "󰖳", "class": "error", "tooltip": "Error checking WinApps status"}'
fi
