resource "azurerm_role_assignment" "docker_acr_push" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPush"
  principal_id                     = azurerm_user_assigned_identity.docker.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "plan_reader" {
  scope                            = azurerm_resource_group.main.id
  role_definition_name             = "Reader"
  principal_id                     = azurerm_user_assigned_identity.plan.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "plan_state" {
  scope                            = azurerm_storage_container.tfstate.id
  role_definition_name             = "Storage Blob Data Contributor"
  principal_id                     = azurerm_user_assigned_identity.plan.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "apply_contributor" {
  scope                            = azurerm_resource_group.main.id
  role_definition_name             = "Contributor"
  principal_id                     = azurerm_user_assigned_identity.apply.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "apply_rbac" {
  scope                            = azurerm_resource_group.main.id
  role_definition_name             = "Role Based Access Control Administrator"
  principal_id                     = azurerm_user_assigned_identity.apply.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "apply_state" {
  scope                            = azurerm_storage_container.tfstate.id
  role_definition_name             = "Storage Blob Data Contributor"
  principal_id                     = azurerm_user_assigned_identity.apply.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "destroy_contributor" {
  scope                            = azurerm_resource_group.main.id
  role_definition_name             = "Contributor"
  principal_id                     = azurerm_user_assigned_identity.destroy.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "destroy_rbac" {
  scope                            = azurerm_resource_group.main.id
  role_definition_name             = "Role Based Access Control Administrator"
  principal_id                     = azurerm_user_assigned_identity.destroy.principal_id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "destroy_state" {
  scope                            = azurerm_storage_container.tfstate.id
  role_definition_name             = "Storage Blob Data Contributor"
  principal_id                     = azurerm_user_assigned_identity.destroy.principal_id
  skip_service_principal_aad_check = true
}