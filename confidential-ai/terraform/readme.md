## Contract generation for Triton Inference Server deployment using an encrypted model

This sample creates an encrypted and signed contract for Triton deployment and stores it locally in a file. A script is bundled in as part of the deployment that will pull down the encrypted model, decrypt and start the server using said model.

### Prerequisite

- Make sure to setup IBM Cloud Logs Instance.
- Setup Artifactory for encrypted model storage
- Encrpyted model and encryption key

### Define your settings

- `log_hostname`="Logging server hostname"
- `log_iam_apikey`="Logging server API key"
- `registry`="icr.io"
- `pull_username`="Username for registry" # Username with read access to the IBM container registry
- `pull_password`="Password for registry" # Password with read access to the IBM container registry
- `b64_user`="Base64 encoded Username for accessing Artifactory"
- `b64_uat`="Base64 encoded Password for accessing Aritfactory"
- `hf_repo`="Name of the repo the object is stored in under Artifactory"
- `b64_key`="Base64 encoded Key used to encrypt/decrypt model"
- `enc_model`="Name of the model when encrypted and stored" # e.g. models.zip.gpg
- `model`="Name of the model to unzip" # e.g. models.zip

The settings are defined in form of Terraform variables.

Use one of the following options to define the variables:

#### Define the variables in a template file

1. `cp my-settings.auto.tfvars-template my-settings.auto.tfvars`
2. Fill the values in `my-settings.auto.tfvars`

#### Define environment variables

Set the following environment variables:

```text
TF_VAR_icl_iam_apikey=
TF_VAR_icl_hostname=
TF_VAR_registry=
TF_VAR_pull_username=
TF_VAR_pull_password=
TF_VAR_b64_user=
TF_VAR_b64_pass=
TF_VAR_ip=
TF_VAR_port=
TF_VAR_repo_name=
TF_VAR_b64_key=
TF_VAR_enc_model=
TF_VAR_model=
```

### Define the workload

The file `compose\docker-compose.yml` has been made for the workload. Specify the sha256 value for the Triton Inference Server image that can be found [here](https://ibm.github.io/ibm-z-oss-hub/containers/ibmz-accelerated-for-nvidia-triton-inference-server.html):

```
services:
  triton-server:
    image: icr.io/ibmz/ibmz-accelerated-for-nvidia-triton-inference-server@sha256:`<sha256value>`
```

### Run the Example

Initialize terraform:

```bash
terraform init
```

Deploy the example:

```bash
terraform apply
```

### Further steps

The contract will be written to the file `build/contract.yml` and can now be used for e.g. provisioning a HPVS for VPC instance.
