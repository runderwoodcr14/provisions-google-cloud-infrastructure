module "kms" {
  source  = "terraform-google-modules/kms/google"
  version = "~> 2.1.0"

  project_id      = var.project_id
  location        = var.location
  prevent_destroy = var.prevent_destroy
  keyring         = var.key_ring_name
  keys            = var.keys
  set_owners_for  = var.owners_for
  owners          = var.owners
}
