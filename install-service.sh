#!/bin/bash

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (using sudo)."
    exit 1
fi

# Define service file path
SERVICE_FILE="mediamtx.service"
TARGET_PATH="/etc/systemd/system/$SERVICE_FILE"

# Check if service file exists
if [ ! -f "$SERVICE_FILE" ]; then
    echo "Error: $SERVICE_FILE not found in the script directory."
    exit 1
fi

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EXECUTABLE="$SCRIPT_DIR/mediamtx"
USER=$(whoami)
WORKING_DIR="$SCRIPT_DIR"

# Check if executable exists
if [ ! -f "$EXECUTABLE" ]; then
    echo "Error: $EXECUTABLE not found in the script directory. Download mediamtx and copy it to this directory, then try again."
    exit 1
fi

# Modify the service file with actual values
temp_file=$(mktemp)
sed -e "s|</path/to/mediamtx>|$EXECUTABLE|g" \
    -e "s|<user>|$USER|g" \
    -e "s|</home/user>|$WORKING_DIR|g" "$SERVICE_FILE" > "$temp_file"

# Copy modified service file to systemd directory
cp "$temp_file" "$TARGET_PATH"
rm "$temp_file"

# Reload systemd to recognize the new service
systemctl daemon-reload

# Enable the service to start on boot
systemctl enable "$SERVICE_FILE"

# Start the service
systemctl start "$SERVICE_FILE"

# Show the service status
systemctl status "$SERVICE_FILE" --no-pager

echo "Service installation completed successfully."
