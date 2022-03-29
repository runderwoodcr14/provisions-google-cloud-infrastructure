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
  project_id  = dependency.service-project.outputs.project_id
  gcp_sa_name = "sops-operator"
  k8s_sa_name = "sops-operator"
  namespace   = "sops"
  create_key  = true
  stage       = include.root.inputs.environment
  roles       = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}
