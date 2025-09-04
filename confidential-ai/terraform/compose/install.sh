#!/bin/bash

echo "Setting up environment..."

apt-get update
apt-get -y upgrade
apt --fix-broken install
apt-get install -y curl
apt-get install -y gnupg

USERNAME=$(echo ${B64_USER} | base64 --decode)
PASSWORD=$(echo ${B64_PASS} | base64 --decode)

echo "Pulling object/archive..."
curl -u ${USERNAME}:${PASSWORD} -L -O http://${IP}:${PORT}/artifactory/${REPO_NAME}/${ENC_MODEL_NAME}

echo "Import Encryption key..."
echo ${B64_KEY} >> b64.key
base64 -d b64.key > decrypt.key
gpg --import decrypt.key

echo "Decrypt zip..."
ls -la
gpg -d -o ${MODEL_NAME} ${ENC_MODEL_NAME}

echo "Extracting archive..."
apt-get install -y unzip
unzip ${MODEL_NAME}

echo "Listing archive..."
ls -la
echo "Listing current directory..."
pwd

echo "Copying files..."
cp -r models/ /models

echo "Starting up application..."
tritonserver --model-repository=/models
