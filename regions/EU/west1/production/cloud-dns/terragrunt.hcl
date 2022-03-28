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
  source = "../../../../../modules//cloud-dns"
}

dependency "host-project" {
  config_path = "../../../../Global/host-project"
}

inputs = {
  project_id    = dependency.host-project.outputs.host_project_id
  type          = "private"
  name          = "domain-local-zone"
  domain        = "prod.domain.local."
  force_destroy = true
  network = [
    "${dependency.host-project.outputs.network_self_link}",
  ]
  labels = {
    environment = "${include.root.inputs.environment}"
    owner       = "terraform"
  }
  recordsets = []
}
