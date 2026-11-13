output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "app_gateway_subnet_id" {
  value = azurerm_subnet.app_gateway.id
}

output "container_app_subnet_id" {
  value = azurerm_subnet.container_app.id
}