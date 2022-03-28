module "dns-zone" {
  source                             = "terraform-google-modules/cloud-dns/google"
  version                            = "4.1.0"
  project_id                         = var.project_id
  type                               = var.type
  name                               = var.name
  domain                             = var.domain
  force_destroy                      = var.force_destroy
  private_visibility_config_networks = var.network
  labels                             = var.labels
  recordsets                         = var.recordsets
}

