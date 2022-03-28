output "names" {
  description = "List of address resource names"
  value       = module.external-ip.names
}

output "addresses" {
  description = "List of address values managed by this module"
  value       = module.external-ip.addresses
}
