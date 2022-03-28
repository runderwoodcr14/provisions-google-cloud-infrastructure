# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

output "host_project_id" {
  description = "Project that holds the base Terraform resources."
  value       = module.host-project.project_id
}

output "bootstrap_tf_gcs_bucket" {
  description = "GCS bucket used for the bootstrap Terraform state."
  value       = module.tf-gcs-bootstrap.name
}

output "host_project_folder" {
  description = "Parent Foldeer"
  value       = google_folder.host-project.id
}

output "environment_folders" {
  description = "Top-level environment folders."
  value       = { for folder in module.environment-folders : folder.name => folder.id }
}

output "environment_tf_gcs_buckets" {
  description = "GCS buckets used for each environment Terraform state."
  value       = { for env, bucket in module.tf-gcs-environments : env => bucket.name }
}

output "environment_service_account_keys" {
  description = "Service account keys used to run each environment Terraform modules."
  sensitive   = true
  value       = { for env, sa in module.tf-service-accounts : env => sa.key }
}

output "environment_service_account" {
  description = "Service accounts used to run each environment Terraform modules."
  value       = { for env, sa in module.tf-service-accounts : env => sa.email }
}

output "host_project_service_accounts" {
  description = "Service accounts used to run each environment Terraform modules."
  value       = module.host-service-account.email
}

output "host_project_service_account_key" {
  description = "Service accounts used to run each environment Terraform modules."
  sensitive   = true
  value       = module.host-service-account.key
}

output "audit_logs_bq_dataset" {
  description = "Bigquery dataset for the audit logs export."
  value       = module.audit-dataset.id
}

output "audit_logs_project" {
  description = "Project that holds the audit logs export resources."
  value       = module.audit-project.project_id
}

output "network" {
  value       = module.vpc
  description = "The created network"
}

output "subnets" {
  value       = module.vpc.subnets
  description = "A map with keys of form subnet_region/subnet_name and values being the outputs of the google_compute_subnetwork resources used to create corresponding subnets."
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.vpc.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets_ids" {
  value       = module.vpc.subnets_ids
  description = "The IDs of the subnets being created"
}

output "subnets_self_links" {
  value       = module.vpc.subnets_self_links
  description = "The self-links of subnets being created"
}

