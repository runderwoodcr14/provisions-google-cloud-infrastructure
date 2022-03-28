<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_kms"></a> [kms](#module\_kms) | terraform-google-modules/kms/google | ~> 2.1.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_decrypters"></a> [decrypters](#input\_decrypters) | List of comma-separated owners for each key declared in set\_decrypters\_for. | `list(string)` | `[]` | no |
| <a name="input_encrypters"></a> [encrypters](#input\_encrypters) | List of comma-separated owners for each key declared in set\_encrypters\_for. | `list(string)` | `[]` | no |
| <a name="input_key_algorithm"></a> [key\_algorithm](#input\_key\_algorithm) | The algorithm to use when creating a version based on this template. See the https://cloud.google.com/kms/docs/reference/rest/v1/CryptoKeyVersionAlgorithm for possible inputs. | `string` | `"GOOGLE_SYMMETRIC_ENCRYPTION"` | no |
| <a name="input_key_protection_level"></a> [key\_protection\_level](#input\_key\_protection\_level) | The protection level to use when creating a version based on this template. Default value: "SOFTWARE" Possible values: ["SOFTWARE", "HSM"] | `string` | `"SOFTWARE"` | no |
| <a name="input_key_ring_name"></a> [key\_ring\_name](#input\_key\_ring\_name) | Keyring name. | `string` | n/a | yes |
| <a name="input_key_rotation_period"></a> [key\_rotation\_period](#input\_key\_rotation\_period) | n/a | `string` | `"100000s"` | no |
| <a name="input_keys"></a> [keys](#input\_keys) | Key names. | `list(string)` | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels, provided as a map | `map(string)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | Location for the keyring. | `string` | `"europe"` | no |
| <a name="input_owners"></a> [owners](#input\_owners) | List of comma-separated owners for each key declared in set\_owners\_for. | `list(string)` | `[]` | no |
| <a name="input_owners_for"></a> [owners\_for](#input\_owners\_for) | Name of keys for which owners will be set. | `list(string)` | `[]` | no |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Set the prevent\_destroy lifecycle attribute on keys. | `bool` | `true` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project id where the keyring will be created. | `string` | n/a | yes |
| <a name="input_set_decrypters_for"></a> [set\_decrypters\_for](#input\_set\_decrypters\_for) | Name of keys for which decrypters will be set. | `list(string)` | `[]` | no |
| <a name="input_set_encrypters_for"></a> [set\_encrypters\_for](#input\_set\_encrypters\_for) | Name of keys for which encrypters will be set. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_keyring"></a> [keyring](#output\_keyring) | Self link of the keyring. |
| <a name="output_keyring_name"></a> [keyring\_name](#output\_keyring\_name) | Name of the keyring. |
| <a name="output_keyring_resource"></a> [keyring\_resource](#output\_keyring\_resource) | Keyring resource. |
| <a name="output_keys"></a> [keys](#output\_keys) | Map of key name => key self link. |
<!-- END_TF_DOCS -->