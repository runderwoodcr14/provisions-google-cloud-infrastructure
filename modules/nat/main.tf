module "cloud-nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "~> 2.1"

  project_id                         = var.project_id
  region                             = var.region
  router                             = var.router
  name                               = "${var.nat_name}-${var.router}"
  nat_ips                            = var.nat_addresses
  min_ports_per_vm                   = var.min_ports_per_vm
  icmp_idle_timeout_sec              = var.icmp_idle_timeout_sec
  tcp_established_idle_timeout_sec   = var.tcp_established_idle_timeout_sec
  tcp_transitory_idle_timeout_sec    = var.tcp_transitory_idle_timeout_sec
  udp_idle_timeout_sec               = var.tcp_transitory_idle_timeout_sec
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  subnetworks                        = var.subnetworks
}
