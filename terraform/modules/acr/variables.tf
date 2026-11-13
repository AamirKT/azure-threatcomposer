variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure Container Registry."
  type        = string
}

variable "location" {
  description = "The location in which to create the Azure Container Registry."
  type        = string
}

variable "sku" {
  description = "The SKU of the Azure Container Registry."
  type        = string
}

variable "admin_enabled" {
  description = "Whether the admin user is enabled for the Azure Container Registry."
  type        = bool
}