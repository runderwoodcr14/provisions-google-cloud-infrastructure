<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.firewall_vpn](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.vpn](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_can_ip_forward"></a> [can\_ip\_forward](#input\_can\_ip\_forward) | n/a | `bool` | `true` | no |
| <a name="input_count_instance"></a> [count\_instance](#input\_count\_instance) | =============================================== Count of PVE servers =============================================== | `string` | `"1"` | no |
| <a name="input_disk_image"></a> [disk\_image](#input\_disk\_image) | n/a | `string` | `"ubuntu-2004-focal-v20210720"` | no |
| <a name="input_instance_tag"></a> [instance\_tag](#input\_instance\_tag) | n/a | `string` | `"vpn-server"` | no |
| <a name="input_parent"></a> [parent](#input\_parent) | n/a | `string` | `""` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"europe-west1"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | n/a | `string` | n/a | yes |
| <a name="input_subnet"></a> [subnet](#input\_subnet) | n/a | `string` | n/a | yes |
| <a name="input_zone_instance"></a> [zone\_instance](#input\_zone\_instance) | n/a | `string` | `"europe-west1-d"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | n/a |
<!-- END_TF_DOCS -->