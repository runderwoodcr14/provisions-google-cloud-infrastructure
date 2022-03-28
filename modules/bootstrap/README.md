<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_audit-dataset"></a> [audit-dataset](#module\_audit-dataset) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/bigquery-dataset | v14.0.0 |
| <a name="module_audit-project"></a> [audit-project](#module\_audit-project) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/project | v14.0.0 |
| <a name="module_environment-folders"></a> [environment-folders](#module\_environment-folders) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder | v14.0.0 |
| <a name="module_host-project"></a> [host-project](#module\_host-project) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/project | v14.0.0 |
| <a name="module_host-project-folder"></a> [host-project-folder](#module\_host-project-folder) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder | v14.0.0 |
| <a name="module_host-service-account"></a> [host-service-account](#module\_host-service-account) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/iam-service-account | v14.0.0 |
| <a name="module_root_folder"></a> [root\_folder](#module\_root\_folder) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/folder | v14.0.0 |
| <a name="module_root_org"></a> [root\_org](#module\_root\_org) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/organization | v14.0.0 |
| <a name="module_tf-gcs-bootstrap"></a> [tf-gcs-bootstrap](#module\_tf-gcs-bootstrap) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/gcs | v14.0.0 |
| <a name="module_tf-gcs-environments"></a> [tf-gcs-environments](#module\_tf-gcs-environments) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/gcs | v14.0.0 |
| <a name="module_tf-service-accounts"></a> [tf-service-accounts](#module\_tf-service-accounts) | git::https://github.com/terraform-google-modules/cloud-foundation-fabric.git//modules/iam-service-account | v14.0.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-google-modules/network/google | ~> 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_folder.host-project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/folder) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_filter"></a> [audit\_filter](#input\_audit\_filter) | Audit log filter used for the log sink. | `string` | `"  logName: \"/logs/cloudaudit.googleapis.com%2Factivity\"\n  OR\n  logName: \"/logs/cloudaudit.googleapis.com%2Fsystem_event\"\n"` | no |
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in auto subnet mode and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. | `bool` | `false` | no |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | Billing account id used as to create projects. | `string` | n/a | yes |
| <a name="input_default_region"></a> [default\_region](#input\_default\_region) | Default Region Location'. | `string` | `"europe-west3"` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_environments"></a> [environments](#input\_environments) | Environment short names. | `set(string)` | n/a | yes |
| <a name="input_firewall_rules"></a> [firewall\_rules](#input\_firewall\_rules) | List of firewall rules. | `any` | `[]` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Optional map to set force destroy keyed by name, defaults to false. | `bool` | `false` | no |
| <a name="input_gcs_location"></a> [gcs\_location](#input\_gcs\_location) | GCS bucket location. | `string` | `"EU"` | no |
| <a name="input_global_user"></a> [global\_user](#input\_global\_user) | Creates a user to be use by Terraform as the service account in all projects. | `string` | n/a | yes |
| <a name="input_iam_audit_viewers"></a> [iam\_audit\_viewers](#input\_iam\_audit\_viewers) | Audit project viewers, in IAM format. | `list(string)` | `[]` | no |
| <a name="input_iam_billing_config"></a> [iam\_billing\_config](#input\_iam\_billing\_config) | Control granting billing user role to service accounts. Target the billing account by default. | <pre>object({<br>    grant      = bool<br>    target_org = bool<br>  })</pre> | <pre>{<br>  "grant": true,<br>  "target_org": false<br>}</pre> | no |
| <a name="input_iam_folder_roles"></a> [iam\_folder\_roles](#input\_iam\_folder\_roles) | List of roles granted to each service account on its respective folder (excluding XPN roles). | `list(string)` | <pre>[<br>  "roles/compute.networkAdmin",<br>  "roles/owner",<br>  "roles/container.hostServiceAgentUser",<br>  "roles/resourcemanager.folderViewer",<br>  "roles/resourcemanager.projectCreator",<br>  "roles/compute.securityAdmin"<br>]</pre> | no |
| <a name="input_iam_shared_owners"></a> [iam\_shared\_owners](#input\_iam\_shared\_owners) | Shared services project owners, in IAM format. | `list(string)` | `[]` | no |
| <a name="input_iam_terraform_owners"></a> [iam\_terraform\_owners](#input\_iam\_terraform\_owners) | Terraform project owners, in IAM format. | `list(string)` | `[]` | no |
| <a name="input_iam_xpn_config"></a> [iam\_xpn\_config](#input\_iam\_xpn\_config) | Control granting Shared VPC creation roles to service accounts. Target the root node by default. | <pre>object({<br>    grant      = bool<br>    target_org = bool<br>  })</pre> | <pre>{<br>  "grant": true,<br>  "target_org": true<br>}</pre> | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically. | `number` | `0` | no |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | The name of the network being created. | `string` | `"shared-network"` | no |
| <a name="input_organization_id"></a> [organization\_id](#input\_organization\_id) | Organization id in organizations/nnnnnnnn format. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used for resources that need unique names. | `string` | n/a | yes |
| <a name="input_project_services"></a> [project\_services](#input\_project\_services) | Service APIs enabled by default in new projects. | `list(string)` | <pre>[<br>  "container.googleapis.com",<br>  "stackdriver.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "cloudkms.googleapis.com",<br>  "compute.googleapis.com",<br>  "dataproc.googleapis.com",<br>  "dataflow.googleapis.com",<br>  "logging.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "cloudbuild.googleapis.com",<br>  "iam.googleapis.com",<br>  "admin.googleapis.com",<br>  "appengine.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "pubsub.googleapis.com",<br>  "securitycenter.googleapis.com",<br>  "accesscontextmanager.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "dns.googleapis.com"<br>]</pre> | no |
| <a name="input_root_node"></a> [root\_node](#input\_root\_node) | Root node for the new hierarchy, either 'organizations/org\_id' or 'folders/folder\_id'. | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | List of routes being created in this VPC. | `list(map(string))` | `[]` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL'). | `string` | `"GLOBAL"` | no |
| <a name="input_secondary_ranges"></a> [secondary\_ranges](#input\_secondary\_ranges) | List of routes being created in this VPC. | <pre>map(list(object({ <br>      range_name = string, <br>      ip_cidr_range = string <br>    })))</pre> | n/a | yes |
| <a name="input_service_account_keys"></a> [service\_account\_keys](#input\_service\_account\_keys) | Generate and store service account keys in the state file. | `bool` | `true` | no |
| <a name="input_shared_vpc_host"></a> [shared\_vpc\_host](#input\_shared\_vpc\_host) | Makes this project a Shared VPC host if 'true' (default 'true'). | `bool` | `true` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Define the different subnets to be used by the VPC | `list(map(string))` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_audit_logs_bq_dataset"></a> [audit\_logs\_bq\_dataset](#output\_audit\_logs\_bq\_dataset) | Bigquery dataset for the audit logs export. |
| <a name="output_audit_logs_project"></a> [audit\_logs\_project](#output\_audit\_logs\_project) | Project that holds the audit logs export resources. |
| <a name="output_bootstrap_tf_gcs_bucket"></a> [bootstrap\_tf\_gcs\_bucket](#output\_bootstrap\_tf\_gcs\_bucket) | GCS bucket used for the bootstrap Terraform state. |
| <a name="output_environment_folders"></a> [environment\_folders](#output\_environment\_folders) | Top-level environment folders. |
| <a name="output_environment_service_account"></a> [environment\_service\_account](#output\_environment\_service\_account) | Service accounts used to run each environment Terraform modules. |
| <a name="output_environment_service_account_keys"></a> [environment\_service\_account\_keys](#output\_environment\_service\_account\_keys) | Service account keys used to run each environment Terraform modules. |
| <a name="output_environment_tf_gcs_buckets"></a> [environment\_tf\_gcs\_buckets](#output\_environment\_tf\_gcs\_buckets) | GCS buckets used for each environment Terraform state. |
| <a name="output_host_project_folder"></a> [host\_project\_folder](#output\_host\_project\_folder) | Parent Foldeer |
| <a name="output_host_project_id"></a> [host\_project\_id](#output\_host\_project\_id) | Project that holds the base Terraform resources. |
| <a name="output_host_project_service_account_key"></a> [host\_project\_service\_account\_key](#output\_host\_project\_service\_account\_key) | Service accounts used to run each environment Terraform modules. |
| <a name="output_host_project_service_accounts"></a> [host\_project\_service\_accounts](#output\_host\_project\_service\_accounts) | Service accounts used to run each environment Terraform modules. |
| <a name="output_network"></a> [network](#output\_network) | The created network |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_network_self_link"></a> [network\_self\_link](#output\_network\_self\_link) | The URI of the VPC being created |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | A map with keys of form subnet\_region/subnet\_name and values being the outputs of the google\_compute\_subnetwork resources used to create corresponding subnets. |
| <a name="output_subnets_ids"></a> [subnets\_ids](#output\_subnets\_ids) | The IDs of the subnets being created |
| <a name="output_subnets_self_links"></a> [subnets\_self\_links](#output\_subnets\_self\_links) | The self-links of subnets being created |
<!-- END_TF_DOCS -->