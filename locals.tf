locals {
  resource_group_name = strcontains(var.private_endpoint.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.private_endpoint.resource_group) :  var.resource_groups[var.private_endpoint.resource_group].name
}