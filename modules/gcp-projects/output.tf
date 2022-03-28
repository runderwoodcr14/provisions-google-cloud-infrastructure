output "project_id" {
  description = "Newly created Project."
  value       = module.add-project.project_id
}

output "service_accounts" {
  description = "Newly created Service Accounts."
  value       = module.add-project.service_account_email
}

output "service_accounts_ids" {
  description = "Newly created Service Accounts."
  value       = module.add-project.service_account_id
}

output "service_accounts_names" {
  description = "Newly created Service Accounts."
  value       = module.add-project.service_account_name
}
