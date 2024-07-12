resource "azurerm_private_endpoint" "pe" {
  name = "${var.name}-pe"
  location = var.location
  resource_group_name = local.resource_group_name
  subnet_id = var.subnets[var.private_endpoint.subnet_name].id

  dynamic "private_dns_zone_group" {
    for_each = try(var.private_endpoint.local_dns_zone, false) != false ? [1] : []
      content {
      name = var.private_endpoint.local_dns_zone
      private_dns_zone_ids = [var.private_dns_zone_id]
    }
  }

  private_service_connection {
    name = "${var.name}-con"
    is_manual_connection = false
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names = var.private_endpoint.subresource_names
  }

  tags = var.tags

  lifecycle {
    ignore_changes = [ tags, private_dns_zone_group ]
  }
}

# module "private_dns_zone" {
#   source = "/home/max/devops/modules/terraform-azurerm-caf-private_dns_zone"
#   count = try(var.private_endpoint.local_dns_zone, false) != false ? 1 : 0

#   private_dns_zone = var.private_endpoint.local_dns_zone
#   resource_groups = var.resource_groups
#   subnet_id = azurerm_private_endpoint.pe.subnet_id
#   tags = var.tags
# }