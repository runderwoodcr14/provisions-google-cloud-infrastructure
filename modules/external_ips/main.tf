module "external-ip" {
  source       = "terraform-google-modules/address/google"
  version      = "3.0.0"
  project_id   = var.project_id
  region       = var.region
  address_type = var.address_type
  names        = var.reservation_names
}
