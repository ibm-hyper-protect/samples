#!/bin/bash
set -eu

apt-get update
apt-get install -y openssl

echo "To be, or not to be, that is the question:"
echo "Suffer the slings and arrows of outrageous fortune." | /bin/bash /var/logging/bin/encrypt-log.sh /var/logging/logging.pub