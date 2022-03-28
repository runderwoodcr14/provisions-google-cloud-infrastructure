/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster-update-variant"
  version = "20.0.0"

  project_id                         = var.project_id
  network_project_id                 = var.network_project_id
  name                               = var.cluster_name
  region                             = var.region
  regional                           = var.regional
  network                            = var.network
  subnetwork                         = var.subnetwork
  ip_range_pods                      = var.ip_range_pods
  ip_range_services                  = var.ip_range_services
  enable_private_endpoint            = var.enable_private_endpoint
  enable_private_nodes               = var.enable_private_nodes
  network_policy                     = var.network_policy
  horizontal_pod_autoscaling         = var.horizontal_pod_autoscaling
  enable_vertical_pod_autoscaling    = var.enable_vertical_pod_autoscaling
  service_account                    = var.service_account
  enable_resource_consumption_export = var.enable_resource_consumption_export
  enable_network_egress_export       = var.enable_network_egress_export
  enable_shielded_nodes              = var.enable_shielded_nodes
  filestore_csi_driver               = var.filestore_csi_driver
  http_load_balancing                = var.http_load_balancing
  kubernetes_version                 = var.kubernetes_version
  create_service_account             = var.create_service_account
  add_cluster_firewall_rules         = var.add_cluster_firewall_rules
  add_master_webhook_firewall_rules  = var.add_master_webhook_firewall_rules
  firewall_inbound_ports             = var.firewall_inbound_ports
  remove_default_node_pool           = var.remove_default_node_pool
  disable_legacy_metadata_endpoints  = var.disable_legacy_metadata_endpoints
  master_authorized_networks         = var.master_authorized_networks
  default_max_pods_per_node          = var.default_max_pods_per_node
  grant_registry_access              = var.grant_registry_access
  impersonate_service_account        = var.service_account
  monitoring_service                 = var.monitoring_service
  logging_service                    = var.logging_service
  master_ipv4_cidr_block             = var.master_ipv4_cidr_block
  enable_l4_ilb_subsetting           = var.enable_l4_ilb_subsetting
  enable_tpu                         = var.enable_tpu
  gce_pd_csi_driver                  = var.gce_pd_csi_driver
  node_pools                         = var.node_pools
  node_pools_tags                    = var.node_pools_tags
  node_pools_labels                  = var.node_pools_labels
  node_pools_taints                  = var.node_pools_taints
  node_pools_oauth_scopes            = var.node_pools_oauth_scopes

  node_pools_metadata = {
    all = {
      shutdown-script = file("${path.module}/data/shutdown-script.sh")
    }
  }

}
