include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../../modules//workload-identity"
}

dependency "service-project" {
  config_path = "../../service-project"
}

dependency "host-project" {
  config_path = "../../../../../Global/host-project"
}

inputs = {

  external_project_id = dependency.host-project.outputs.host_project_id
  project_id          = dependency.service-project.outputs.project_id
  use_existing_gcp_sa = true
  gcp_sa_name         = dependency.host-project.outputs.host_project_service_accounts
  k8s_sa_name         = "atlantis"
  namespace           = "atlantis"
  stage               = include.root.inputs.environment
}
