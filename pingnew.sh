!/bin/bash

# Find the current IP address and subnet mask
CURRENT_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}(?=/)')
SUBNET_MASK=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}/\d+' | cut -d'/' -f2)

# Calculate the network address (base IP)
IFS=. read -r i1 i2 i3 i4 <<< "$CURRENT_IP"
BASE_IP="$i1.$i2.$i3"

# Ping all addresses in the subnet
for i in {0..255}; do
  IP="$BASE_IP.$i"
  
  # Ping the IP address with a timeout of 1 second
  ping -c 1 -W 1 $IP > /dev/null 2>&1
  
  # Check if the ping command succeeded
  if [ $? -eq 0 ]; then
    echo "Server $IP is up and running"
  else
    echo "Server $IP failed"
  fi
done
