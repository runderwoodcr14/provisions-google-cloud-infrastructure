include "root" {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "../../../../../modules//gke"
}

dependency "host-project" {
  config_path = "../../../../Global/host-project"
}

dependency "service-project" {
  config_path = "../service-project"
}

inputs = {

  project_id              = dependency.service-project.outputs.project_id
  network_project_id      = dependency.host-project.outputs.host_project_id
  cluster_name            = "development-cluster-1"
  region                  = include.root.inputs.region
  regional                = true
  network                 = dependency.host-project.outputs.network_name
  subnetwork              = "europe-west1-subnet-03"
  ip_range_pods           = "europe-west1-subnet-03-secondary-pods"
  ip_range_services       = "europe-west1-subnet-03-secondary-svc"
  service_account         = dependency.service-project.outputs.service_accounts
  enable_private_endpoint = true
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "10.0.0.16/28"
  master_authorized_networks = [
    {
      cidr_block   = "10.20.0.0/14"
      display_name = "All Subnets"
    },
  ]
  network_policy                    = true
  enable_vertical_pod_autoscaling   = true
  create_service_account            = false
  remove_default_node_pool          = true
  disable_legacy_metadata_endpoints = true
  node_pools = [
    {
      name               = "generic-node-pool"
      machine_type       = "e2-standard-2"
      min_count          = 1
      max_count          = 3
      disk_size_gb       = 50
      disk_type          = "pd-ssd"
      spot               = true
      autoscaling        = true
      preemptible        = false
      image_type         = "COS_CONTAINERD"
      auto_repair        = true
      auto_upgrade       = false
      initial_node_count = 1
    },
  ]
  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
  node_pools_labels = {
    all = {
      purpose = "generic"
    }

    my-node-pool1 = {
      apps = false
      core = true
    }
    my-node-pool2 = {
      apps = true
      core = false
    }
    my-node-pool3 = {
      apps         = true
      core         = false
      experimental = true
    }
  }

  node_pools_tags = {
    all = ["fw-allow-health-check", "fw-allow-lb-traffic", "fw-allow-vpn"]
  }
}
