locals {
  resource_group_name = strcontains(var.private_endpoint.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.private_endpoint.resource_group) :  var.resource_groups[var.private_endpoint.resource_group].name
  subnet_name = strcontains(var.private_endpoint.subnet, "/resourceGroups/") ? var.private_endpoint.subnet : var.subnets[var.private_endpoint.subnet].id
  private_dns_zone_id = strcontains(var.private_endpoint.local_dns_zone, "/resourceGroups/") ?  var.private_endpoint.local_dns_zone : var.private_dns_zone_ids[var.private_endpoint.local_dns_zone]
  private_dns_zone_name = strcontains(var.private_endpoint.local_dns_zone, "/resourceGroups/") ? regex("[^\\/]+$", var.private_endpoint.local_dns_zone) : var.private_endpoint.local_dns_zone
}