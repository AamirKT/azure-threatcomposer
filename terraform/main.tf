data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
}

module "vnet" {
  source                      = "./modules/vnet"
  vnet_name                   = var.vnet_name
  resource_group_name         = data.azurerm_resource_group.main.name
  location                    = var.location
  address_space               = var.address_space
  app_gateway_subnet_prefix   = var.app_gateway_subnet_prefix
  container_app_subnet_prefix = var.container_app_subnet_prefix
}

module "container_app" {
  source                      = "./modules/container_app"
  container_app_name          = var.container_app_name
  resource_group_name         = data.azurerm_resource_group.main.name
  location                    = var.location
  container_app_target_port   = var.container_app_target_port
  container_app_env_name      = var.container_app_env_name
  container_app_image         = var.container_app_image
  container_app_cpu           = var.container_app_cpu
  container_app_memory        = var.container_app_memory
  container_app_min_replicas  = var.container_app_min_replicas
  container_app_max_replicas  = var.container_app_max_replicas
  container_app_revision_mode = var.container_app_revision_mode
  log_analytics_workspace_id  = module.monitoring.log_analytics_workspace_id
  container_app_subnet_id     = module.vnet.container_app_subnet_id
  acr_id                      = data.azurerm_container_registry.acr.id
  acr_login_server            = data.azurerm_container_registry.acr.login_server
}

module "monitoring" {
  source                                    = "./modules/monitoring"
  log_analytics_workspace_name              = var.log_analytics_workspace_name
  location                                  = var.location
  resource_group_name                       = data.azurerm_resource_group.main.name
  log_analytics_workspace_retention_in_days = var.log_analytics_workspace_retention_in_days
  application_gateway_id                    = module.application_gateway.application_gateway_id
}

module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = module.container_app.container_app_env_default_domain
  resource_group_name = data.azurerm_resource_group.main.name
  static_ip           = module.container_app.container_app_env_static_ip
  virtual_network_id  = module.vnet.vnet_id
}

module "application_gateway" {
  source                        = "./modules/application_gateway"
  application_gateway_name      = var.application_gateway_name
  resource_group_name           = data.azurerm_resource_group.main.name
  location                      = var.location
  sku_name                      = var.sku_name
  tier                          = var.tier
  minimum_capacity              = var.minimum_capacity
  maximum_capacity              = var.maximum_capacity
  application_gateway_subnet_id = module.vnet.app_gateway_subnet_id
  container_app_fqdn            = module.container_app.container_app_revision_fqdn
  key_vault_id                  = var.key_vault_id
  app_gateway_identity_name     = var.app_gateway_identity_name
  key_vault_secret_id           = var.key_vault_secret_id
}