# Copyright contributors to the project.

import argparse
import json
import requests
import time

# Validate attestation of Inference Server
from io import BytesIO
import os
from requests.packages.urllib3.exceptions import InsecureRequestWarning
import sys
import tarfile

isValidated = False

try:
    expected_user_data = os.environ['EXPECTED_USER_DATA']
except KeyError as e:
    print('Expected environment variable EXPECTED_USER_DATA is not available')
    sys.exit(1)

try:
    server_ip = os.environ['SERVER_IP']
except KeyError as e:
    print('Expected environment variable SERVER_IP is not available')
    sys.exit(1)

requests.packages.urllib3.disable_warnings(InsecureRequestWarning)
response = requests.get('http://' + server_ip + ':80/attestation.tar.gz', verify=False)

with tarfile.open(fileobj=BytesIO(response.content), mode="r:gz") as tf:
    f = tf.extractfile(tf.getmember("/var/hyperprotect/se-checksums.txt"))
    if f is not None:
        for line in f.readlines():
            txt = line.decode('utf-8').replace("\n","")
            if (txt.endswith(' cidata/user-data')):
                txt = txt.removesuffix(' cidata/user-data')
                isValidated = (txt == expected_user_data)

if not isValidated:
    print('Could not validate the attestation record')
    sys.exit(2)
else:
    print('Successfully validated the attestation record')

CLI = argparse.ArgumentParser()
CLI.add_argument("--model", type=str, default="rf_model")
args = CLI.parse_args()

file1 = open('inference_input.json', 'r')
json_data = json.loads(file1.readlines()[0].replace(" ", ""))

inference_endpoint = "http://"+server_ip+":8000/v2/models/"+args.model+"/infer"
response = requests.post(inference_endpoint, json=json_data)
print(response.text)

