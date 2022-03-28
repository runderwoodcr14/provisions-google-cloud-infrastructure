# Deploying Infrastrucutre in Google Cloud

## Motivation

## Contents

### Pre requisites

### Setup
#### Terraform
#### Terragrunt
To bootstrap the infrastrucutre you'll have to first comment in the backend portion of the root terragrunt.hcl file
```
#remote_state {
#  backend = "gcs"
#  config = {
#    project  = "{HOST_PROJECT_ID}"
#    location = "eu"
#    bucket   = "${local.prefix}-tf-${local.environment}-state"
#    prefix   = "${path_relative_to_include()}/terraform.tfstate"
#
#    gcs_bucket_labels = {
#      owner = "Terraform Global"
#      name  = "terraform_state_storage"
#    }
#  }
#  generate = {
#    path      = "backend.tf"
#    if_exists = "overwrite_terragrunt"
#  }
#}
```
 because we are going to use bucket in Cloud Storage as our backend and the idea is to provision all infra from scratch, we first will use a local backend, once the Global shared VPC has been deployed, just comment out the backend section and run the apply again, this will now transfer the state from the local backend to the Cloud Storage backend


#### Atlantis
