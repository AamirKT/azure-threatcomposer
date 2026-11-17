variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-tfstate"
}

variable "location" {
  description = "The location of the resource group."
  type        = string
  default     = "uksouth"
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
  default     = "tfstate"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
  default     = "threatcomposer"
}

variable "sku" {
  description = "The SKU of the Azure Container Registry."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Whether the admin user is enabled for the Azure Container Registry."
  type        = bool
  default     = false
}

variable "main_resource_group_name" {
  description = "The name of the main resource group."
  type        = string
  default     = "threatcomposer-rg"
}

variable "key_vault_name" {
  description = "The name of the Azure Key Vault."
  type        = string
  default     = "aamir-threatcomposer-kv"
}