terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=5.0.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>5.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "aamirstorage"
    container_name       = "tfstate"
    key                  = "threatcomposer/terraform.tfstate"

    use_azuread_auth = true
    use_oidc         = true
  }
}

provider "azurerm" {
  features {
  }
}

provider "cloudflare" {
}
