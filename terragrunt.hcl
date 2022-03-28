# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  billing_id  = local.account_vars.locals.billing_id
  org_id      = local.account_vars.locals.org_id
  region      = local.region_vars.locals.region
  location    = local.region_vars.locals.location
  environment = local.environment_vars.locals.environment
  prefix      = local.environment_vars.locals.prefix
}

remote_state {
  backend = "gcs"
  config = {
    project  = "xxx-host-project-xxx"
    location = "eu"
    bucket   = "${local.prefix}-tf-${local.environment}-state"
    prefix   = "${path_relative_to_include()}/terraform.tfstate"

    gcs_bucket_labels = {
      owner = "Terraform Global"
      name  = "terraform_state_storage"
    }
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "versions" {
  path = "versions.tf"

  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.14.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.14.0"
    }
  }
}

EOF
}

# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
