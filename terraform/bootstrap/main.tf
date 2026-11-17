resource "azurerm_resource_group" "tfstate_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Name = var.resource_group_name
  }
}

resource "azurerm_storage_account" "tfstate" {
  name                            = var.storage_account_name
  resource_group_name             = azurerm_resource_group.tfstate_rg.name
  location                        = azurerm_resource_group.tfstate_rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false

  tags = {
    Name = var.storage_account_name
  }

  lifecycle {
    prevent_destroy = true
  }

  blob_properties {
    delete_retention_policy {
      days = 7
    }

    versioning_enabled = true

    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

resource "azurerm_resource_group" "main" {
  name     = var.main_resource_group_name
  location = var.location

  tags = {
    Name = var.main_resource_group_name
  }
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.main_resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.admin_enabled

  tags = {
    Name = var.acr_name
  }
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                       = var.key_vault_name
  location                   = var.location
  resource_group_name        = var.main_resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  rbac_authorization_enabled = true

  soft_delete_retention_days    = 90
  purge_protection_enabled      = false
  public_network_access_enabled = true

  tags = {
    Name = var.key_vault_name
  }

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }
}