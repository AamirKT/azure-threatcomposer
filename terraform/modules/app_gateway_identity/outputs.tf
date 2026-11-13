output "app_gateway_identity_id" {
  description = "The ID of the application gateway identity"
  value       = azurerm_user_assigned_identity.app_gateway_identity.id
}
output "app_gateway_identity_client_id" {
  description = "The client ID of the application gateway identity"
  value       = azurerm_user_assigned_identity.app_gateway_identity.client_id
}
output "app_gateway_identity_principal_id" {
  description = "The principal ID of the application gateway identity"
  value       = azurerm_user_assigned_identity.app_gateway_identity.principal_id
}
