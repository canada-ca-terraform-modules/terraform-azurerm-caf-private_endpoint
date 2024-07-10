output "private-endpoint-object" {
  description = "Returns the Private Endpoint object"
  value = azurerm_private_endpoint.pe
}

output "id" {
  description = "Returns the ID of the private endpoint"
  value = azurerm_private_endpoint.pe.id
}

output "name" {
  description = "Returns the name of the private endpoint"
  value = azurerm_private_endpoint.pe
}