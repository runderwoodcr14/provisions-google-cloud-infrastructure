<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_sa_label"></a> [gcp\_sa\_label](#module\_gcp\_sa\_label) | cloudposse/label/null | n/a |

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.workload_identity_sa_bindings](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.cluster_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.wiu_role_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |
| [google_service_account_key.cluster_service_account_key](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_key) | resource |
| [google_service_account.cluster_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_key"></a> [create\_key](#input\_create\_key) | Create Authetication Key for Service Account | `bool` | `false` | no |
| <a name="input_external_gsa_project"></a> [external\_gsa\_project](#input\_external\_gsa\_project) | Is the GSA located in an different project? | `bool` | `false` | no |
| <a name="input_external_project_id"></a> [external\_project\_id](#input\_external\_project\_id) | GCP Project what host the resource that needs to be accessed | `string` | `null` | no |
| <a name="input_gcp_sa_name"></a> [gcp\_sa\_name](#input\_gcp\_sa\_name) | Name for the Google service account; overrides. | `string` | `null` | no |
| <a name="input_k8s_sa_name"></a> [k8s\_sa\_name](#input\_k8s\_sa\_name) | Name for the Kubernetes service account; overrides. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace for the Kubernetes service account | `string` | `"default"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP Service project ID | `string` | n/a | yes |
| <a name="input_roles"></a> [roles](#input\_roles) | A list of roles to be added to the created service account | `list(string)` | `[]` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Environment the account will be created on | `string` | `"default"` | no |
| <a name="input_use_existing_gcp_sa"></a> [use\_existing\_gcp\_sa](#input\_use\_existing\_gcp\_sa) | Use an existing Google service account instead of creating one | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_service_account"></a> [gcp\_service\_account](#output\_gcp\_service\_account) | GCP service account. |
| <a name="output_gcp_service_account_email"></a> [gcp\_service\_account\_email](#output\_gcp\_service\_account\_email) | Email address of GCP service account. |
| <a name="output_gcp_service_account_fqn"></a> [gcp\_service\_account\_fqn](#output\_gcp\_service\_account\_fqn) | FQN of GCP service account. |
| <a name="output_gcp_service_account_key"></a> [gcp\_service\_account\_key](#output\_gcp\_service\_account\_key) | GCP service account key. |
| <a name="output_gcp_service_account_name"></a> [gcp\_service\_account\_name](#output\_gcp\_service\_account\_name) | Name of GCP service account. |
<!-- END_TF_DOCS -->