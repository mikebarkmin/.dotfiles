#!/bin/bash

COMPOSE_DIR="/home/mike/.local/bin/winapps-src"
COMPOSE_FILE="$COMPOSE_DIR/compose.yaml"

# Check if compose file exists
if [ ! -f "$COMPOSE_FILE" ]; then
  notify-send "WinApps" "compose.yaml not found" -u critical
  exit 1
fi

# Change to the compose directory
cd "$COMPOSE_DIR" || exit 1

# Check current status
RUNNING_CONTAINERS=$(podman-compose ps -q 2>/dev/null | wc -l)

if [ "$RUNNING_CONTAINERS" -gt 0 ]; then
  # Containers are running, stop them
  if podman-compose down; then
    notify-send "WinApps" "Containers stopped" -u normal
  else
    notify-send "WinApps" "Failed to stop containers" -u critical
  fi
else
  # Containers are stopped, start them
  if podman-compose up -d; then
    notify-send "WinApps" "Containers started" -u normal
  else
    notify-send "WinApps" "Failed to start containers" -u critical
  fi
fi
