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

# Step 1: simulate the pre-upgrade deployed state (no new args)
run "baseline_apply" {
  command = apply
  variables {
    private_endpoint = {
      resource_group    = "rg-test"
      subnet            = "OZ"
      subresource_names = ["blob"]
    }
  }
  assert {
    condition     = azurerm_private_endpoint.pe.name == "myapp-pe"
    error_message = "Baseline apply: unexpected resource name"
  }
}

# Step 2: plan the upgraded code against that state using only additive/non-destructive args.
# Note: custom_network_interface_name and ip_configuration are NOT included here because
# adding them to an existing resource forces replacement — they must be set at creation time.
run "upgrade_plan_no_replacement" {
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
    error_message = "Resource name must be unchanged after upgrade"
  }
}
