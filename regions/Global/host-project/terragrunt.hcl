# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that helps keep your code DRY and
# maintainable: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# Include configurations that are common used across multiple environments.
# ---------------------------------------------------------------------------------------------------------------------

# Include the root `terragrunt.hcl` configuration. The root configuration contains settings that are common across all
# components and environments, such as how to configure remote state.
include "root" {
  path   = find_in_parent_folders()
  expose = true
}

# Include the envcommon configuration for the component. The envcommon configuration contains settings that are common
# for the component across all environments.
terraform {
  source = "../../../modules//bootstrap"
}

inputs = {
  billing_account_id   = include.root.inputs.billing_id
  organization_id      = include.root.inputs.org_id
  root_node            = include.root.inputs.org_id
  prefix               = include.root.inputs.prefix
  environments         = (["development", "staging", "production", "common"])
  iam_terraform_owners = ["user:user@domain.com"]
  force_destroy        = true
  global_user          = "terraform-global"

  ###############################################################################
  #                    Shared VPC Variables                                     #
  ###############################################################################
  network_name   = "global-network-demo"
  default_region = include.root.inputs.environment

  subnets = [
    {
      subnet_name               = "europe-west1-subnet-01"
      description               = "This subnet has a description"
      subnet_ip                 = "10.21.0.0/22"
      subnet_region             = "europe-west1"
      subnet_private_access     = "true"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
    {
      subnet_name               = "europe-west1-subnet-02"
      description               = "This subnet has a description"
      subnet_ip                 = "10.21.4.0/22"
      subnet_region             = "europe-west1"
      subnet_private_access     = "true"
      subnet_flow_logs          = "true"
      subnet_flow_logs_interval = "INTERVAL_10_MIN"
      subnet_flow_logs_sampling = 0.7
      subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
    },
  ]

  secondary_ranges = {
    europe-west1-subnet-01 = [
      {
        range_name    = "europe-west1-subnet-01-secondary-pods"
        ip_cidr_range = "172.16.0.0/20"
      },
      {
        range_name    = "europe-west1-subnet-01-secondary-svc"
        ip_cidr_range = "192.168.0.0/22"
      },
    ]
    europe-west1-subnet-02 = [
      {
        range_name    = "europe-west1-subnet-02-secondary-pods"
        ip_cidr_range = "172.16.16.0/20"
      },
      {
        range_name    = "europe-west1-subnet-02-secondary-svc"
        ip_cidr_range = "192.168.4.0/22"
      },
    ]
  }

}
