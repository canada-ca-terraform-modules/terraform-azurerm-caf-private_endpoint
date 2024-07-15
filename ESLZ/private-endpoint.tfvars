private_endpoint = {
  blob = {                                                     # Key defines the userDefinedstring
    resource_group       = "Project"                           # Required: Resource group name, i.e Project, Management, DNS, etc, or the resource group ID
    subnet               = "OZ"                                # Required: Subnet name, i.e OZ,MAZ, etc, or the subnet ID
    subresource_names    = ["blob"]                            # Required: Subresource name determines to what service the private endpoint will connect to. see: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for list of subresrouce
    is_manual_connection = false                               # Optional: Possible values: true, false. Default: true
    local_dns_zone       = "privatelink.blob.core.windows.net" # Optional: Name of the local DNS zone for the private endpoint
  }
}
