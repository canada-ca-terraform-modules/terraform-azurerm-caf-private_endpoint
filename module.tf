resource "azurerm_private_endpoint" "pe" {
  name = "${var.name}-pe"
  location = var.location
  resource_group_name = local.resource_group_name
  subnet_id = local.subnet_id

  # Private DNS zone group might not be set depending on use case
  dynamic "private_dns_zone_group" {
    for_each = try(var.private_endpoint.local_dns_zone, false) != false ? [1] : []
      content {
      name = local.private_dns_zone_name
      private_dns_zone_ids = [local.private_dns_zone_id]
    }
  }

  private_service_connection {
    name = "${var.name}-con"
    is_manual_connection = try(var.private_endpoint.is_manual_connection, false)
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names = var.private_endpoint.subresource_names
  }

  tags = merge(var.tags, try(var.private_endpoint.tags, {}))

  # Private DNS zone group is included in ignore_changes to not conflict when policies deploy the DNS config for a PE
  lifecycle {
    ignore_changes = [ tags, private_dns_zone_group ]
  }
}