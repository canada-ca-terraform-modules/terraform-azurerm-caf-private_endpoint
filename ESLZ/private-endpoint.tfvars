private_endpoint = {
  blob = {                           # Key defines the userDefinedstring
    resource_group       = "Project" # Required: Resource group name, i.e Project, Management, DNS, etc, or the resource group ID
    subnet               = "OZ"      # Required: Subnet name, i.e OZ,MAZ, etc, or the subnet ID
    subresource_names    = ["blob"]  # Required: Even if it's a list, only one resource is allowed for most first party Azure resource. It's a terraform requirement. See: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview#private-link-resource for list of subresrouce
    is_manual_connection = false     # Optional: Possible values: true, false. Default: false
    # local_dns_zone       = "privatelink.blob.core.windows.net"   # Optional: Name of the local DNS zone for the private endpoint. To change this value, you must taint the associated resource

    # --- New arguments (azurerm >= 4.x) ---

    # custom_network_interface_name = "myapp-pe-nic"               # Optional: Custom NIC name for the private endpoint. Changing this forces a new resource.

    # ip_configuration = [                                          # Optional: Static IP address configuration (instead of dynamic allocation).
    #   {
    #     name               = "static-ip-1"                        # Required: Name for this IP configuration.
    #     private_ip_address = "10.0.2.10"                          # Required: Static private IP address within the subnet.
    #     subresource_name   = "blob"                               # Optional: Subresource this IP applies to (group_id).
    #     member_name        = "blob"                               # Optional: Member name; defaults to subresource_name if omitted.
    #   }
    # ]

    # --- Private Link Service Alias (alternative to resource ID) ---
    # private_connection_resource_alias = "example-privatelinkservice.d20286c8-4ea5-11eb-9584-8f53157226c6.centralus.azure.privatelinkservice"  # Optional: Use instead of private_connection_resource_id when connecting via alias.
    # is_manual_connection              = true                      # Required when using alias.
    # request_message                   = "Please approve"          # Optional: Message to resource owner (manual connections only, max 140 chars).
  }
}

