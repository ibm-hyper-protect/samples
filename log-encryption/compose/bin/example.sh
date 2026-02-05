#!/bin/bash
set -eu

apt-get update
apt-get install -y openssl

# Run infinite loop
while true; do
    date | while IFS= read -r line; do
        # Print to screen
        echo "Screen: $line"
        # Send to your encrypt script
        echo "$line" | /bin/bash /var/logging/bin/encrypt-log.sh /var/logging/logging.pub
    done
    sleep 1
done
