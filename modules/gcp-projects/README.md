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
| <a name="module_add-project"></a> [add-project](#module\_add-project) | terraform-google-modules/project-factory/google//modules/svpc_service_project | ~> 12.0.0 |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.bind_roles_default_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.bind_roles_project_sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_audit_filter"></a> [audit\_filter](#input\_audit\_filter) | Audit log filter used for the log sink. | `string` | `"  logName: \"/logs/cloudaudit.googleapis.com%2Factivity\"\n  OR\n  logName: \"/logs/cloudaudit.googleapis.com%2Fsystem_event\"\n"` | no |
| <a name="input_billing_account_id"></a> [billing\_account\_id](#input\_billing\_account\_id) | Billing account id used as default for new projects. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The Project Environment. | `string` | n/a | yes |
| <a name="input_host-project"></a> [host-project](#input\_host-project) | The Host Project to which the current Project will be attached | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | Organization ID. | `string` | n/a | yes |
| <a name="input_parent"></a> [parent](#input\_parent) | The Folder under which the Project will be created. | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used for resources that need unique names. | `string` | n/a | yes |
| <a name="input_project_services"></a> [project\_services](#input\_project\_services) | Service APIs enabled by default in new projects. | `list(string)` | <pre>[<br>  "container.googleapis.com",<br>  "stackdriver.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "servicenetworking.googleapis.com",<br>  "cloudkms.googleapis.com",<br>  "compute.googleapis.com",<br>  "dataproc.googleapis.com",<br>  "dataflow.googleapis.com",<br>  "logging.googleapis.com",<br>  "bigquery.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "cloudbilling.googleapis.com",<br>  "cloudbuild.googleapis.com",<br>  "iam.googleapis.com",<br>  "admin.googleapis.com",<br>  "appengine.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "monitoring.googleapis.com",<br>  "pubsub.googleapis.com",<br>  "securitycenter.googleapis.com",<br>  "accesscontextmanager.googleapis.com",<br>  "billingbudgets.googleapis.com",<br>  "dns.googleapis.com"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | Default Region | `string` | `"europe-west3"` | no |
| <a name="input_roles"></a> [roles](#input\_roles) | n/a | `set(string)` | <pre>[<br>  "monitoring.editor",<br>  "container.serviceAgent",<br>  "iam.workloadIdentityUser",<br>  "compute.networkUser"<br>]</pre> | no |
| <a name="input_shared_vpc_service"></a> [shared\_vpc\_service](#input\_shared\_vpc\_service) | Prefix used for resources that need unique names. | `bool` | `true` | no |
| <a name="input_subnets_ids"></a> [subnets\_ids](#input\_subnets\_ids) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Newly created Project. |
| <a name="output_service_accounts"></a> [service\_accounts](#output\_service\_accounts) | Newly created Service Accounts. |
| <a name="output_service_accounts_ids"></a> [service\_accounts\_ids](#output\_service\_accounts\_ids) | Newly created Service Accounts. |
| <a name="output_service_accounts_names"></a> [service\_accounts\_names](#output\_service\_accounts\_names) | Newly created Service Accounts. |
<!-- END_TF_DOCS -->