include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules//gcp-projects"
}

dependency "host-project" {
  config_path = "../../../../Global/host-project"

  # Configure mock outputs for the `validate` command that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

inputs = {
  billing_account_id = include.root.inputs.billing_id
  parent             = dependency.host-project.outputs.environment_folders["${include.root.inputs.environment}"]
  prefix             = include.root.inputs.prefix
  host-project       = dependency.host-project.outputs.host_project_id
  environment        = include.root.inputs.environment
  org_id             = include.root.inputs.org_id
  region             = include.root.inputs.region
  subnets_ids = [
    "europe-west1-subnet-05",
    "europe-west1-subnet-06",
  ]
}
