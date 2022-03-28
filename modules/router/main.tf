module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 1.3.0"

  name    = var.name
  network = var.network
  region  = var.region
  project = var.project
  bgp     = var.bgp
}
