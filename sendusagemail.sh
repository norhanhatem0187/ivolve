#!/bin/bash

# Email configuration
TO_ADDRESS="norhan.hatem0187@gmail.com"
SUBJECT="Disk Space Alert"

# Threshold percentage for disk usage
THRESHOLD=5

# Get current disk usage
DISK_USAGE=$(df -h | grep -E '^/dev/' | awk '{print $5 " " $1}' | sort -n | tail -1 | awk '{print $1}' | sed 's/%//')

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
  # Get the full disk usage report
  FULL_REPORT=$(df -h)
  
  # Compose the email
  BODY="Warning: Disk usage has exceeded the threshold of $THRESHOLD%.\n\nCurrent Disk Usage: $DISK_USAGE%\n\nFull Disk Usage Report:\n$FULL_REPORT"
  
  # Send the email
  echo -e "$BODY" | mail -s "$SUBJECT" "$TO_ADDRESS"
fi
