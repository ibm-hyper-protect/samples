variable "log_hostname" {
  type        = string
  description = <<-DESC
                  Host of IBM Cloud Logs. This can be
                  obtained from cloud logs tab under Logging instances
                DESC
}

variable "log_iam_apikey" {
  type        = string
  sensitive   = true
  description = <<-DESC
                  This can be obtained from Access(IAM) under Manage
                DESC
}

variable "registry" {
  type        = string
  description = <<-DESC
                  Prefix of the container registry used to pull the image
                DESC
}

variable "b64_user" {
  type        = string
  description = <<-DESC
                  Username for accessing Artifactory
                DESC
}

variable "b64_uat" {
  type        = string
  sensitive   = true
  description = <<-DESC
                  Password for accessing Artifactory
                DESC
}


variable "hf_repo" {
  type        = string
  description = <<-DESC
                 Repo the object is stored in under Artifactory
                DESC
}

variable "b64_key" {
  type        = string
  sensitive   = true
  description = <<-DESC
                  Key Identifier
                DESC
}

variable "enc_model" {
  type        = string
  description = <<-DESC
                  Name of encrypted model in storage
                DESC
}

variable "model" {
  type        = string
  description = <<-DESC
                  Name of model to be used at runtime
                DESC
}

variable "pull_username" {
  type        = string
  description = <<-DESC
                  Username to pull from the above registry
                DESC
}

variable "pull_password" {
  type        = string
  description = <<-DESC
                  Password to pull from the above registry
                DESC
}
