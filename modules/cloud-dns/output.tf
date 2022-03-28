output "name_servers" {
  description = "Zone name servers."
  value       = module.dns-zone.name_servers
}
