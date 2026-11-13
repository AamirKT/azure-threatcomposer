module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "vnet" {
  source                      = "./modules/vnet"
  vnet_name                   = var.vnet_name
  resource_group_name         = var.resource_group_name
  location                    = var.location
  address_space               = var.address_space
  app_gateway_subnet_prefix   = var.app_gateway_subnet_prefix
  container_app_subnet_prefix = var.container_app_subnet_prefix
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
}

module "container_app" {
  source                      = "./modules/container_app"
  container_app_name          = var.container_app_name
  resource_group_name         = var.resource_group_name
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
  acr_login_server            = var.acr_login_server
}

module "monitoring" {
  source                                    = "./modules/monitoring"
  log_analytics_workspace_name              = var.log_analytics_workspace_name
  location                                  = var.location
  resource_group_name                       = var.resource_group_name
  log_analytics_workspace_retention_in_days = var.log_analytics_workspace_retention_in_days
  application_gateway_id                    = module.application_gateway.application_gateway_id
}

module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = var.dns_zone_name
  resource_group_name = var.resource_group_name
  static_ip           = var.static_ip
  virtual_network_id  = module.vnet.vnet_id
}

module "application_gateway" {
  source                        = "./modules/application_gateway"
  application_gateway_name      = var.application_gateway_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku_name                      = var.sku_name
  tier                          = var.tier
  minimum_capacity              = var.minimum_capacity
  maximum_capacity              = var.maximum_capacity
  application_gateway_subnet_id = module.vnet.app_gateway_subnet_id
  container_app_fqdn            = var.container_app_fqdn
  identity_id                   = module.app_gateway_identity.app_gateway_identity_id
  key_vault_secret_id           = var.key_vault_secret_id
}

module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "app_gateway_identity" {
  source                    = "./modules/app_gateway_identity"
  app_gateway_identity_name = var.app_gateway_identity_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
}

resource "azurerm_role_assignment" "app_gateway_key_vault" {
  principal_id         = module.app_gateway_identity.app_gateway_identity_principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = module.key_vault.key_vault_id
}