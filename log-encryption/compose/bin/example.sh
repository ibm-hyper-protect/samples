#!/bin/bash
set -eu

apt-get update
apt-get install -y openssl

echo "To be, or not to be, that is the question:"
echo "This message is generated from Hyper Protect Virtual Server (HPVS) through Docker Compose Contract." \
    | /bin/bash /var/logging/bin/encrypt-log.sh /var/logging/logging.pub
