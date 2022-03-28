locals{
  shared_subnets = [for subnet in var.subnets_ids : 
    "projects/${var.host-project}/regions/${var.region}/subnetworks/${subnet}"
  ]
}


