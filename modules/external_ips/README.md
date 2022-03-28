<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_external-ip"></a> [external-ip](#module\_external-ip) | terraform-google-modules/address/google | 3.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_type"></a> [address\_type](#input\_address\_type) | The type of address to reserve, either "INTERNAL" or "EXTERNAL". If unspecified, defaults to "INTERNAL". | `string` | `"EXTERNAL"` | no |
| <a name="input_global"></a> [global](#input\_global) | The scope in which the address should live. If set to true, the IP address will be globally scoped. Defaults to false, i.e. regionally scoped. When set to true, do not provide a subnetwork. | `bool` | `false` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The Google Cloud project ID to deploy to | `string` | n/a | yes |
| <a name="input_reservation_names"></a> [reservation\_names](#input\_reservation\_names) | A list of IP address resource names to create.  This is the GCP resource name and not the associated hostname of the IP address.  Existing resource names may be found with `gcloud compute addresses list` (e.g. ["gusw1-dev-fooapp-fe-0001-a-001-ip"]) | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_addresses"></a> [addresses](#output\_addresses) | List of address values managed by this module |
| <a name="output_names"></a> [names](#output\_names) | List of address resource names |
<!-- END_TF_DOCS -->