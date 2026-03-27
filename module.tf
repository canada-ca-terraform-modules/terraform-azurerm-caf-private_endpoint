resource "azurerm_private_endpoint" "pe" {
  name                          = "${var.name}-pe"
  location                      = var.location
  resource_group_name           = local.resource_group_name
  subnet_id                     = local.subnet_id
  custom_network_interface_name = try(var.private_endpoint.custom_network_interface_name, var.custom_network_interface_name, null)

  # Private DNS zone group might not be set depending on use case
  dynamic "private_dns_zone_group" {
    for_each = try(var.private_endpoint.local_dns_zone, false) != false ? [1] : []
    content {
      name                 = local.private_dns_zone_name
      private_dns_zone_ids = [local.private_dns_zone_id]
    }
  }

  private_service_connection {
    name                              = "${var.name}-con"
    is_manual_connection              = try(var.private_endpoint.is_manual_connection, false)
    private_connection_resource_id    = try(var.private_endpoint.private_connection_resource_alias, null) == null ? var.private_connection_resource_id : null
    private_connection_resource_alias = try(var.private_endpoint.private_connection_resource_alias, null)
    subresource_names                 = try(var.private_endpoint.subresource_names, null)
    request_message                   = try(var.private_endpoint.is_manual_connection, false) ? try(var.private_endpoint.request_message, null) : null
  }

  dynamic "ip_configuration" {
    for_each = try(tolist(var.private_endpoint.ip_configuration), try(tolist(var.ip_configuration), []))
    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = try(ip_configuration.value.subresource_name, null)
      member_name        = try(ip_configuration.value.member_name, null)
    }
  }

  tags = merge(var.tags, try(var.private_endpoint.tags, {}))

  # Private DNS zone group is included in ignore_changes to not conflict when policies deploy the DNS config for a PE
  lifecycle {
    ignore_changes = [private_dns_zone_group]
  }
}