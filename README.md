## Requirements

No requirements.

## Providers

| Name |
|------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the private endpoint | `string` | n/a | yes |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | (Required) The ID of the resource the private endpoint will be connected to | `string` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | (Required) Resource group object of private endpoint | `any` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) Map of subnets | `any` | n/a | yes |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | (Required) Private endpoint object | `any` | `{}` | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location where the private endpoint will be located | `any` | `"canadacentral"` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | List of private DNS zone ids | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the private endpoint | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Returns the ID of the private endpoint |
| <a name="output_name"></a> [name](#output\_name) | Returns the name of the private endpoint |
| <a name="output_private-endpoint-object"></a> [private-endpoint-object](#output\_private-endpoint-object) | Returns the Private Endpoint object |

## TFVars Parameters

For more information about storage account parameters, refer to the terraform docs: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
| Name | Possible values | Default | Required |
|------|----------|----------------|---------|
| <a name="resource_group"></a> [resource_group](#resource\_group) | Resource group name, i.e Project, Managment, DNS, etc, or resource group ID | n/a | yes |
|<a name="subnet"></a> [subnet](#subnet) | Subnet name, i.e OZ, MAZ, etc, or subnet ID | n/a | yes |
|<a name="subnet"></a> [subnet](#subnet) | Subnet name, i.e OZ, MAZ, etc, or subnet ID | n/a | yes |
|<a name="subresource_name"></a> [subresource_name](#subresource\_name) | Subresource name. Most native Azure resources only support one subresource name per private endpoint. See: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for a comprehensive list of subresources | n/a | yes |
|<a name="is_manual_connection"></a> [is_manual_connection](#is\_manual\_connection) | true, false | false | no |
|<a name="local_dns_zone"></a> [local_dns_zone](#local\_dns\_zone) | Name of a private_dns_zone or ID of a private DNS zone | n\a | no |