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
  description = "Billing account id used as to create projects."
  type        = string
}

variable "environments" {
  description = "Environment short names."
  type        = set(string)
}

variable "gcs_location" {
  description = "GCS bucket location."
  type        = string
  default     = "EU"
}

variable "iam_audit_viewers" {
  description = "Audit project viewers, in IAM format."
  type        = list(string)
  default     = []
}

variable "iam_billing_config" {
  description = "Control granting billing user role to service accounts. Target the billing account by default."
  type = object({
    grant      = bool
    target_org = bool
  })
  default = {
    grant      = true
    target_org = false
  }
}

variable "iam_folder_roles" {
  description = "List of roles granted to each service account on its respective folder (excluding XPN roles)."
  type        = list(string)
  default = [
    "roles/compute.networkAdmin",
    "roles/owner",
    "roles/container.hostServiceAgentUser",
    "roles/resourcemanager.folderViewer",
    "roles/resourcemanager.projectCreator",
    "roles/compute.securityAdmin"
  ]
}

variable "iam_shared_owners" {
  description = "Shared services project owners, in IAM format."
  type        = list(string)
  default     = []
}

variable "iam_terraform_owners" {
  description = "Terraform project owners, in IAM format."
  type        = list(string)
  default     = []
}

variable "iam_xpn_config" {
  description = "Control granting Shared VPC creation roles to service accounts. Target the root node by default."
  type = object({
    grant      = bool
    target_org = bool
  })
  default = {
    grant      = true
    target_org = true
  }
}

variable "global_user" {
  description = "Creates a user to be use by Terraform as the service account in all projects."
  type        = string
}

variable "organization_id" {
  description = "Organization id in organizations/nnnnnnnn format."
  type        = string
}

variable "prefix" {
  description = "Prefix used for resources that need unique names."
  type        = string
}

variable "root_node" {
  description = "Root node for the new hierarchy, either 'organizations/org_id' or 'folders/folder_id'."
  type        = string
}

variable "default_region" {
  description = "Default Region Location'."
  type        = string
  default     = "europe-west3"
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

variable "force_destroy"{
    description = "Optional map to set force destroy keyed by name, defaults to false."
    type        = bool
    default     = false
}

variable "service_account_keys" {
  description = "Generate and store service account keys in the state file."
  type        = bool
  default     = true
}

variable "routing_mode" {
  description = "The network routing mode (default 'GLOBAL')."
  type        = string
  default     = "GLOBAL"
}

variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in auto subnet mode and it will create a subnet for each region automatically across the 10.128.0.0/9 address range."
  type        = bool
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted."
  type        = bool
  default     = false
}

variable "shared_vpc_host" {
  description = "Makes this project a Shared VPC host if 'true' (default 'true')."
  type        = bool
  default     = true
}

variable "description" {
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  type        = string
  default     = ""
}

variable "firewall_rules" {
  description = "List of firewall rules."
  type        = any
  default     = []
}

variable "mtu" {
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  type        = number
  default     = 0
}

variable "network_name" {
  description = "The name of the network being created."
  type        = string
  default     = "shared-network"
}

############################################################################################
#                        routes Definition Variable                                        #
############################################################################################
# routes = [
#         {
#             name                   = "egress-internet" The name of the route being created
#             description            = "route through IGW to access internet" The description of the route being created
#             destination_range      = "0.0.0.0/0" The destination range of outgoing packets that this route applies to. Only IPv4 is supported
#             tags                   = "egress-inet" The network tags assigned to this route. This is a list in string format. Eg. "tag-01,tag-02"
#             next_hop_internet      = "true" Whether the next hop to this route will the default internet gateway. Use "true" to enable this as next hop
#             next_hop_ip            = "192.168.1.1" Network IP address of an instance that should handle matching packets
#             next_hop_vpn_tunnel    = "" URL to a VpnTunnel that should handle matching packets
#             priority               = "1000"
#
#         },
#         {
#             name                   = "app-proxy" The name of the route being created
#             description            = "route through proxy to reach app" The description of the route being created
#             destination_range      = "10.50.10.0/24" The destination range of outgoing packets that this route applies to. Only IPv4 is supported
#             tags                   = "app-proxy" The network tags assigned to this route. This is a list in string format. Eg. "tag-01,tag-02"
#             next_hop_instance      = "app-proxy-instance" URL or name of an instance that should handle matching packets. If just name is specified "next_hop_instance_zone" is required
#             next_hop_instance_zone = "us-west1-a" The zone of the instance specified in next_hop_instance. Only required if next_hop_instance is specified as a name
#         },
# ]
variable "routes" {
  description = "List of routes being created in this VPC."
  type = list(map(string))
  default = []
}


############################################################################################
#                        secondary_range Definition Variable                               #
############################################################################################
#secondary_ranges = {
#        subnet-01 = [
#            {
#                range_name    = "subnet-01-secondary-01"
#                ip_cidr_range = "192.168.64.0/24"
#            },
#            {
#                range_name    = "subnet-01-secondary-02"
#                ip_cidr_range = "172.0.64.0/24"
#            },
#        ]
#
#        subnet-02 = []
#    }
variable "secondary_ranges" {
  description = "List of routes being created in this VPC."
  type = map(list(object({ 
      range_name = string, 
      ip_cidr_range = string 
    })))
}

############################################################################################
#                        Subnet Definition Variable                                        #
############################################################################################
# subnets = [
#         {
#             subnet_name           = "subnet-01"
#             subnet_ip             = "10.10.10.0/24"
#             subnet_region         = "us-west1"
#         },
#         {
#             subnet_name           = "subnet-02"
#             subnet_ip             = "10.10.20.0/24"
#             subnet_region         = "us-west1"
#             subnet_private_access = "true"
#             subnet_flow_logs      = "true"
#             description           = "This subnet has a description"
#         },
#         {
#             subnet_name               = "subnet-03" - The name of the subnet being created
#             description               = "This subnet has a description" - An optional description of this resource.
#             subnet_ip                 = "10.10.30.0/24" The IP and CIDR range of the subnet being created
#             subnet_region             = "us-west1" The region where the subnet will be created
#             subnet_private_access     = "true" When enabled, VMs in this subnetwork without external IP addresses can access Google APIs and services by using Private Google Access.(default false)
#             subnet_flow_logs          = "true" Whether the subnet will record and send flow log data to logging(default false)
#             subnet_flow_logs_interval = "INTERVAL_10_MIN" Toggles the aggregation interval for collecting flow logs
#             subnet_flow_logs_sampling = 0.7 Set the sampling rate of VPC flow logs within the subnetwork
#             subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA" Configures whether metadata fields should be added to the reported VPC flow logs
#         }
#     ]
variable "subnets" {
  description = "Define the different subnets to be used by the VPC"
  type = list(map(string))
  default = []
}
