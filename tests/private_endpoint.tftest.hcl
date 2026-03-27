mock_provider "azurerm" {}

variables {
  resource_groups = {
    rg-test = { name = "rg-test", location = "canadacentral" }
  }
  subnets = {
    OZ = { id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet/subnets/OZ" }
  }
  name                           = "myapp"
  private_connection_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Storage/storageAccounts/mystorage"
  tags                           = {}
}

run "default_values" {
  command = plan
  variables {
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.name == "myapp-pe"
    error_message = "Name must be {var.name}-pe"
  }
  assert {
    condition     = azurerm_private_endpoint.pe.private_service_connection[0].name == "myapp-con"
    error_message = "Connection name must be {var.name}-con"
  }
  assert {
    condition     = azurerm_private_endpoint.pe.custom_network_interface_name == null
    error_message = "custom_network_interface_name must be null when not set"
  }
}

run "with_dns_zone_name" {
  command = plan
  variables {
    private_dns_zone_ids = {
      "privatelink.blob.core.windows.net" = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    }
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
      local_dns_zone    = "privatelink.blob.core.windows.net"
    }
  }
  assert {
    condition     = length(azurerm_private_endpoint.pe.private_dns_zone_group) == 1
    error_message = "private_dns_zone_group must be set when local_dns_zone is provided"
  }
}

run "with_dns_zone_id" {
  command = plan
  variables {
    private_dns_zone_ids = {}
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
      local_dns_zone    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    }
  }
  assert {
    condition     = length(azurerm_private_endpoint.pe.private_dns_zone_group) == 1
    error_message = "private_dns_zone_group must be set when local_dns_zone is an ID"
  }
}

run "with_custom_nic_name" {
  command = plan
  variables {
    private_endpoint = {
      resource_group                = "rg-test"
      subnet                        = "OZ"
      subresource_names             = ["blob"]
      custom_network_interface_name = "myapp-pe-nic"
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.custom_network_interface_name == "myapp-pe-nic"
    error_message = "custom_network_interface_name must be set from private_endpoint object"
  }
}

run "with_ip_configuration" {
  command = plan
  variables {
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
      ip_configuration = [
        {
          name               = "static-ip-1"
          private_ip_address = "10.0.2.10"
          subresource_name   = "blob"
          member_name        = "blob"
        }
      ]
    }
  }
  assert {
    condition     = length(azurerm_private_endpoint.pe.ip_configuration) == 1
    error_message = "ip_configuration block must be present when specified"
  }
}

run "with_manual_connection_and_alias" {
  command = plan
  variables {
    private_endpoint = {
      resource_group                    = "rg-test"
      subnet                            = "OZ"
      is_manual_connection              = true
      request_message                   = "Please approve"
      private_connection_resource_alias = "example-privatelinkservice.d20286c8-4ea5-11eb-9584-8f53157226c6.centralus.azure.privatelinkservice"
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.private_service_connection[0].is_manual_connection == true
    error_message = "is_manual_connection must be true"
  }
}

run "rg_provided_as_id" {
  command = plan
  variables {
    private_endpoint = {
      resource_group    = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.resource_group_name == "rg-test"
    error_message = "resource_group_name must be parsed correctly from a full resource group ID"
  }
}

run "subnet_provided_as_id" {
  command = plan
  variables {
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet/subnets/OZ"
      subresource_names = ["blob"]
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.subnet_id == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test/providers/Microsoft.Network/virtualNetworks/vnet/subnets/OZ"
    error_message = "subnet_id must be used as-is when provided as a full resource ID"
  }
}
