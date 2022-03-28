# output "kubernetes_endpoint" {
#   sensitive = true
#   value     = module.gke-cluster.endpoint
# }

# output "ca_certificate" {
#   sensitive = true  
#   value = module.gke-cluster.ca_certificate
# }

# # output "service_account" {
# #   description = "The default service account used for running nodes."
# #   value       = module.node-pools.service_account
# # }

# output "monitoring_service_used" {
#   sensitive = true
#   value     = module.gke-cluster.cluster
# }


# output "rules" {
#   value     = local.fw_rules
# }


output "kubernetes_endpoint" {
  sensitive = true
  value     = module.gke.endpoint
}

output "client_token" {
  sensitive = true
  value     = base64encode(data.google_client_config.default.access_token)
}

output "ca_certificate" {
  sensitive = true
  value     = module.gke.ca_certificate
}

output "service_account" {
  description = "The service account to default running nodes as if not overridden in `node_pools`."
  value       = module.gke.service_account
}
