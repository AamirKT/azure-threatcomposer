resource "azurerm_user_assigned_identity" "app_gateway_identity" {
  name                = var.app_gateway_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Name = var.app_gateway_identity_name
  }
}