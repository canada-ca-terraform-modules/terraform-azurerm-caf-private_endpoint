locals {
  # RG, subnet and private_dns_zone might be a ID or a name. If it's an ID, than it must contain /resourceGroups/, then we parse the name from the ID. 
  # If we received a name, we get the full name with the object provided by ESLZ
  # If provided with an RG ID, then the name will be everything after the last /, captured bt the regex
  resource_group_name = strcontains(var.private_endpoint.resource_group, "/resourceGroups/") ? regex("[^\\/]+$", var.private_endpoint.resource_group) :  var.resource_groups[var.private_endpoint.resource_group].name
  
  # If we received a subnet ID then we leave it as is, if not then we get the ID from the subnet object
  subnet_id = strcontains(var.private_endpoint.subnet, "/resourceGroups/") ? var.private_endpoint.subnet : var.subnets[var.private_endpoint.subnet].id

  # Same logic as subnet ID
  private_dns_zone_id = strcontains(var.private_endpoint.local_dns_zone, "/resourceGroups/") ?  var.private_endpoint.local_dns_zone : var.private_dns_zone_ids[var.private_endpoint.local_dns_zone]

  #Same logic as resource_group_name
  private_dns_zone_name = strcontains(var.private_endpoint.local_dns_zone, "/resourceGroups/") ? regex("[^\\/]+$", var.private_endpoint.local_dns_zone) : var.private_endpoint.local_dns_zone
}