include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules//pritunl"
}

dependency "host-project" {
  config_path = "../../../../Global/host-project"
}

dependency "service-project" {
  config_path = "../service-project"
}

inputs = {
  project         = dependency.service-project.outputs.project_id
  parent          = dependency.host-project.outputs.host_project_id
  region          = include.root.inputs.region
  subnet          = "https://www.googleapis.com/compute/v1/projects/its-host-project-uldx/regions/europe-west1/subnetworks/europe-west1-subnet-02"
  service_account = dependency.service-project.outputs.service_accounts
}
