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

###############################################################################
#                        Terraform top-level resources                        #
###############################################################################

resource "random_string" "suffix" {
  length  = 30 - length(local.parent) - 1
  upper   = false
  number  = false
  special = false
}

resource "google_folder" "host-project" {
  display_name = "${var.prefix}-host-project"
  parent       = local.parent
}


# Terraform project

module "host-project" {
  source          = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/project?ref=v14.0.0"
  name            = "host-project-${random_string.suffix.result}"
  parent          = google_folder.host-project.id
  prefix          = var.prefix
  billing_account = var.billing_account_id
  services        = var.project_services

  shared_vpc_host_config = {
    enabled          = true
    service_projects = [] # defined later
  }
  iam_additive    = {
    "roles/owner" = var.iam_terraform_owners
  }
}

# Host project service account
module "host-service-account" {
  source       = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/iam-service-account?ref=v14.0.0"
  project_id   = module.host-project.project_id
  name         = var.global_user
  prefix       = var.prefix
  generate_key = var.service_account_keys
  iam_billing_roles = {
    (var.billing_account_id) = (
      var.iam_billing_config.grant ? local.sa_billing_account_role : []
    )
  }
  # folder roles are set in the folders module using authoritative bindings
  iam_organization_roles = {
    (local.organization_id) = concat(
      var.iam_billing_config.grant ? local.sa_billing_org_role : [],
      var.iam_xpn_config.grant ? local.sa_xpn_org_roles : []
    )
  }
}

module "host-project-folder" {
  source        = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder?ref=v14.0.0"
  folder_create = false
  parent        = local.parent
  name          = "${var.prefix}-host-project"
  id            = google_folder.host-project.id

  iam = {
    for role in local.folder_roles :
    (role) => [module.host-service-account.iam_email]
  }
}


# per-environment service accounts

module "tf-service-accounts" {
  source       = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/iam-service-account?ref=v14.0.0"
  for_each     = var.environments
  project_id   = module.host-project.project_id
  name         = each.value
  prefix       = var.prefix
  generate_key = var.service_account_keys

  iam_billing_roles = {
    (var.billing_account_id) = (
      var.iam_billing_config.grant ? local.sa_billing_account_role : []
    )
  }
  # folder roles are set in the folders module using authoritative bindings
  iam_organization_roles = {
    (local.organization_id) = concat(
      var.iam_billing_config.grant ? local.sa_billing_org_role : [],
      var.iam_xpn_config.grant ? local.sa_xpn_org_roles : []
    )
  }
}

# bootstrap Terraform state GCS bucket

module "tf-gcs-bootstrap" {
  source        = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/gcs?ref=v14.0.0"
  project_id    = module.host-project.project_id
  name          = "host-project-state"
  force_destroy = var.force_destroy
  prefix        = "${var.prefix}-tf"
  location      = var.gcs_location
}

# per-environment Terraform state GCS buckets

module "tf-gcs-environments" {
  source        = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/gcs?ref=v14.0.0"
  for_each      = var.environments
  project_id    = module.host-project.project_id
  name          = "${each.value}-state"
  prefix        = "${var.prefix}-tf"
  force_destroy = var.force_destroy
  location      = var.gcs_location

  iam = {
    "roles/storage.objectAdmin" = [module.tf-service-accounts[each.value].iam_email]
  }
}

###############################################################################
#                              Top-level folders                              #
###############################################################################

module "environment-folders" {
  source   = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder?ref=v14.0.0"
  for_each = var.environments
  parent   = google_folder.host-project.id
  name     = each.value

  iam = {
    for role in local.folder_roles :
    (role) => [module.tf-service-accounts[each.value].iam_email]
  }
}

###############################################################################
#                              Audit log exports                              #
###############################################################################

# audit logs project

module "audit-project" {
  source          = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/project?ref=v14.0.0"
  name            = "audit-${random_string.suffix.result}"
  parent          = google_folder.host-project.id
  prefix          = var.prefix
  billing_account = var.billing_account_id

  iam = {
    "roles/viewer" = var.iam_audit_viewers
  }
  services = concat(var.project_services, [
    "bigquery.googleapis.com",
  ])
}

# # audit logs dataset and sink

module "audit-dataset" {
  source        = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/bigquery-dataset?ref=v14.0.0"
  project_id    = module.audit-project.project_id
  id            = "audit_export"
  friendly_name = "Audit logs export."
  # disable delete on destroy for actual use
  options = {
    default_table_expiration_ms     = null
    default_partition_expiration_ms = null
    delete_contents_on_destroy      = true
  }
}

module "root_org" {
  count           = local.root_node_type == "organizations" ? 1 : 0
  source          = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/organization?ref=v14.0.0"
  organization_id = local.parent
  logging_sinks   = local.logging_sinks
}

module "root_folder" {
  count         = local.root_node_type == "folders" ? 1 : 0
  source        = "git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder?ref=v14.0.0"
  id            = local.parent
  folder_create = false
  logging_sinks = local.logging_sinks
}


###############################################################################
#                    Shared resources (GCR, GCS, KMS, etc.)                   #
###############################################################################
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 5.0.0"

  auto_create_subnetworks                = var.auto_create_subnetworks
  project_id                             = module.host-project.project_id
  shared_vpc_host                        = var.shared_vpc_host
  delete_default_internet_gateway_routes = var.delete_default_internet_gateway_routes
  network_name                           = var.network_name
  routing_mode                           = var.routing_mode
  subnets                                = var.subnets
  secondary_ranges                       = var.secondary_ranges
  routes                                 = var.routes
}
