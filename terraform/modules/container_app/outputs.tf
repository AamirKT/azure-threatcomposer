output "container_apps_env_id" {
  description = "The ID of the container apps environment"
  value       = azurerm_container_app_environment.container_app_env.id
}

output "container_app_env_static_ip" {
  description = "The static IP of the container apps environment"
  value       = azurerm_container_app_environment.container_app_env.static_ip_address
}

output "container_app_env_default_domain" {
  description = "The default domain of the container apps environment"
  value       = azurerm_container_app_environment.container_app_env.default_domain
}

output "container_app_id" {
  description = "The ID of the container app"
  value       = azurerm_container_app.container_app.id
}

output "container_app_latest_revision" {
  description = "The latest revision of the container app"
  value       = azurerm_container_app.container_app.latest_revision_name
}

output "container_app_revision_fqdn" {
  description = "The FQDN of the container app's latest revision"
  value       = azurerm_container_app.container_app.latest_revision_fqdn
}

output "container_app_identity_principal_id" {
  description = "The principal ID of the container app's managed identity"
  value       = azurerm_container_app.container_app.identity[0].principal_id
}