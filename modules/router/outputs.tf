output "router" {
  value       = module.cloud_router.router
  description = "The created router"
}

output "router_name" {
  value       = var.name
  description = "Router Name"
}
