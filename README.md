# terraform-azurerm-caf-private_endpoint

Creates an Azure Private Endpoint using the ESLZ CAF pattern, supporting DNS zone groups, static IP allocation, custom NIC naming, and Private Link Service aliases.

## Usage

### ESLZ module block (`ESLZ/private-endpoint.tf`)

```hcl
module "private_endpoint" {
  source   = "github.com/ssc-spc-ccoe-cei/terraform-azurerm-caf-private_endpoint?ref=v1.2.0"
  for_each = var.private_endpoint

  name                           = each.key
  private_connection_resource_id = var.private_connection_resource_id
  resource_groups                = var.resource_groups
  subnets                        = var.subnets
  private_dns_zone_ids           = var.private_dns_zone_ids
  tags                           = var.tags
  private_endpoint               = each.value
}
```

### ESLZ tfvars pattern (`ESLZ/private-endpoint.tfvars`)

```hcl
private_endpoint = {
  blob = {
    resource_group    = "Project"              # or full resource group ID
    subnet            = "OZ"                   # or full subnet resource ID
    subresource_names = ["blob"]
    # local_dns_zone  = "privatelink.blob.core.windows.net"

    # New in azurerm >= 4.x:
    # custom_network_interface_name = "myapp-pe-nic"
    # ip_configuration = [{ name = "static-ip-1", private_ip_address = "10.0.2.10", subresource_name = "blob" }]
    # private_connection_resource_alias = "example.d20286c8.centralus.azure.privatelinkservice"
    # request_message = "Please approve"  # only when is_manual_connection = true
  }
}
```

## New arguments (azurerm >= 4.x / 5.x)

| Key (in `private_endpoint` object) | Type | Description |
|---|---|---|
| `custom_network_interface_name` | string | Custom NIC name. Changing this forces resource replacement. |
| `ip_configuration` | list(object) | Static IP configuration blocks. Each requires `name`, `private_ip_address`; optional `subresource_name`, `member_name`. |
| `private_connection_resource_alias` | string | Private Link Service alias. Use instead of `private_connection_resource_id` when connecting via alias. |
| `request_message` | string | Message to resource owner (manual connections only, max 140 chars). |

## Testing

```bash
terraform fmt -recursive && terraform init -backend=false && terraform validate && terraform test
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.pe](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_network_interface_name"></a> [custom\_network\_interface\_name](#input\_custom\_network\_interface\_name) | (Optional) The custom name of the network interface attached to the private endpoint. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | (Optional) One or more ip\_configuration blocks to set static IP addresses for the private endpoint. Each block requires: name, private\_ip\_address; optional: subresource\_name, member\_name. | `any` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Azure location where the private endpoint will be located | `any` | `"canadacentral"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name of the private endpoint | `string` | n/a | yes |
| <a name="input_private_connection_resource_id"></a> [private\_connection\_resource\_id](#input\_private\_connection\_resource\_id) | (Optional) The ID of the resource the private endpoint will be connected to. Required unless private\_connection\_resource\_alias is set in the private\_endpoint object. | `string` | `null` | no |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | List of private DNS zone ids | `any` | `{}` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | (Required) Private endpoint object | `any` | `{}` | no |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | (Required) Resource group object of private endpoint | `any` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | (Required) Map of subnets | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to the private endpoint | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Returns the ID of the private endpoint |
| <a name="output_name"></a> [name](#output\_name) | Returns the name of the private endpoint |
| <a name="output_private-endpoint-object"></a> [private-endpoint-object](#output\_private-endpoint-object) | Returns the Private Endpoint object |
<!-- END_TF_DOCS -->
