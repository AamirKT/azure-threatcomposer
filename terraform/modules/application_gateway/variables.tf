variable "application_gateway_name" {
  description = "The name of the application gateway"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the application gateway"
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the application gateway"
  type        = string
}

variable "tier" {
  description = "The tier of the application gateway"
  type        = string
}

variable "minimum_capacity" {
  description = "The minimum capacity of the application gateway"
  type        = number
}

variable "maximum_capacity" {
  description = "The maximum capacity of the application gateway"
  type        = number
}

variable "application_gateway_subnet_id" {
  description = "The ID of the subnet for the application gateway"
  type        = string
}

variable "container_app_fqdn" {
  description = "The FQDN of the container app"
  type        = string
}

variable "identity_id" {
  description = "The ID of the user-assigned identity for the application gateway"
  type        = string
}

variable "key_vault_secret_id" {
  description = "The ID of the key vault secret for the SSL certificate"
  type        = string
}