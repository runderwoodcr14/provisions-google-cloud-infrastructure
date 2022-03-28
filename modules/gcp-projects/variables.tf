/**
 * Copyright 2021 Google LLC
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

variable "audit_filter" {
  description = "Audit log filter used for the log sink."
  type        = string
  default     = <<END
  logName: "/logs/cloudaudit.googleapis.com%2Factivity"
  OR
  logName: "/logs/cloudaudit.googleapis.com%2Fsystem_event"
  END
}

variable "billing_account_id" {
  description = "Billing account id used as default for new projects."
  type        = string
}

variable "prefix" {
  description = "Prefix used for resources that need unique names."
  type        = string
}

variable "org_id" {
  description = "Organization ID."
  type        = string
}

variable "environment" {
  description = "The Project Environment."
  type        = string
}

variable "parent" {
  description = "The Folder under which the Project will be created."
  type        = string
}

variable "shared_vpc_service" {
  description = "Prefix used for resources that need unique names."
  type        = bool
  default     = true
}

variable "host-project" {
  description = "The Host Project to which the current Project will be attached"
  type        = string
}

variable "project_services" {
  description = "Service APIs enabled by default in new projects."
  type        = list(string)
  default = [
    "container.googleapis.com",
    "stackdriver.googleapis.com",
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "cloudkms.googleapis.com",
    "compute.googleapis.com",
    "dataproc.googleapis.com",
    "dataflow.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "pubsub.googleapis.com",
    "securitycenter.googleapis.com",
    "accesscontextmanager.googleapis.com",
    "billingbudgets.googleapis.com",
    "dns.googleapis.com"
  ]
}

variable "region" {
  description = "Default Region"
  type        = string
  default     = "europe-west3"
}

variable "roles" {
  description = ""
  type        = set(string)
  default     = ([
    "monitoring.editor",
    "container.serviceAgent",
    "iam.workloadIdentityUser",
    "compute.networkUser"
  ])
}

variable "subnets_ids" {
  description = ""
  type        = list(string)
  default     = []
}
