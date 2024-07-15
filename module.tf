resource "azurerm_private_endpoint" "pe" {
  name = "${var.name}-pe"
  location = var.location
  resource_group_name = local.resource_group_name
  subnet_id = var.subnets[var.private_endpoint.subnet_name].id

  dynamic "private_dns_zone_group" {
    for_each = try(var.private_endpoint.local_dns_zone, false) != false ? [1] : []
      content {
      name = local.private_dns_zone_name
      private_dns_zone_ids = [local.private_dns_zone_id]
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