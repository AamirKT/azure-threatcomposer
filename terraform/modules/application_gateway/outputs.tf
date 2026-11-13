output "application_gateway_public_ip" {
  description = "The public IP address of the application gateway"
  value       = azurerm_public_ip.application_gateway_ip.ip_address
}

output "application_gateway_public_ip_id" {
  description = "The ID of the public IP address of the application gateway"
  value       = azurerm_public_ip.application_gateway_ip.id
}

output "application_gateway_public_fqdn" {
  description = "The public FQDN of the application gateway"
  value       = azurerm_public_ip.application_gateway_ip.fqdn
}

output "application_gateway_id" {
  description = "The ID of the application gateway"
  value       = azurerm_application_gateway.app_gateway.id
}