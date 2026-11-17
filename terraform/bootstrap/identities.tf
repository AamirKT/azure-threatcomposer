resource "azurerm_user_assigned_identity" "docker" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "docker-identity"

  tags = {
    Name = "threatcomposer-docker-identity"
  }
}

resource "azurerm_user_assigned_identity" "plan" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "plan-identity"

  tags = {
    Name = "threatcomposer-plan-identity"
  }
}

resource "azurerm_user_assigned_identity" "apply" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "apply-identity"
  tags = {
    Name = "threatcomposer-apply-identity"
  }
}

resource "azurerm_user_assigned_identity" "destroy" {
  resource_group_name = var.resource_group_name
  location            = var.location
  name                = "destroy-identity"
  tags = {
    Name = "threatcomposer-destroy-identity"
  }
}

resource "azurerm_federated_identity_credential" "docker" {
  name                      = "docker-federated-identity"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.docker.id
  subject                   = "repo:AamirKT/azure-threatcomposer:ref:refs/heads/main"
}

resource "azurerm_federated_identity_credential" "plan" {
  name                      = "plan-federated-identity"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.plan.id
  subject                   = "repo:AamirKT/azure-threatcomposer:ref:refs/heads/main"
}
resource "azurerm_federated_identity_credential" "apply" {
  name                      = "apply-federated-identity"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.apply.id
  subject                   = "repo:AamirKT/azure-threatcomposer:environment:production"

}
resource "azurerm_federated_identity_credential" "destroy" {
  name                      = "destroy-federated-identity"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  user_assigned_identity_id = azurerm_user_assigned_identity.destroy.id
  subject                   = "repo:AamirKT/azure-threatcomposer:environment:destroy"
}






