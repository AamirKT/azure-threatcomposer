variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "threatcomposer-rg"
}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "uksouth"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default     = "threatcomposer"
}

variable "sku" {
  description = "The SKU of the Azure Container Registry"
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Whether the admin user is enabled for the Azure Container Registry"
  type        = bool
  default     = true
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "threatcomposer-vnet"
}

variable "address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "app_gateway_subnet_prefix" {
  description = "The address prefix of the app gateway subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "container_app_subnet_prefix" {
  description = "The address prefix of the container apps subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "container_app_env_name" {
  description = "The name of the container apps environment"
  type        = string
  default     = "threatcomposer-env"
}

variable "container_app_name" {
  description = "The name of the container app"
  type        = string
  default     = "threatcomposer-app"
}

variable "container_app_image" {
  description = "The container image for the container app"
  type        = string
  default     = "threatcomposer.azurecr.io/threatcomposer:v1"
}

variable "container_app_cpu" {
  description = "The CPU allocation for the container app"
  type        = string
  default     = "0.5"
}

variable "container_app_memory" {
  description = "The memory allocation for the container app"
  type        = string
  default     = "1Gi"
}

variable "container_app_min_replicas" {
  description = "The minimum number of replicas for the container app"
  type        = number
  default     = 2
}

variable "container_app_max_replicas" {
  description = "The maximum number of replicas for the container app"
  type        = number
  default     = 5
}

variable "container_app_target_port" {
  description = "The target port for the container app"
  type        = number
  default     = 80
}

variable "container_app_revision_mode" {
  description = "The revision mode for the container app"
  type        = string
  default     = "Single"
}

variable "log_analytics_workspace_name" {
  description = "The name of the Log Analytics workspace"
  type        = string
  default     = "threatcomposer-law"
}

variable "log_analytics_workspace_retention_in_days" {
  description = "The retention period of the Log Analytics workspace in days"
  type        = number
  default     = 30
}

variable "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  type        = string
  default     = "threatcomposer.azurecr.io"
}

variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
  default     = "greenwave-6d7b6ee1.uksouth.azurecontainerapps.io"
}

variable "static_ip" {
  description = "The static IP address for the DNS A record"
  type        = string
  default     = "10.0.2.112"
}

variable "application_gateway_name" {
  description = "The name of the application gateway"
  type        = string
  default     = "threatcomposer-app-gateway"
}

variable "sku_name" {
  description = "The SKU name of the application gateway"
  type        = string
  default     = "Standard_v2"
}

variable "tier" {
  description = "The tier of the application gateway"
  type        = string
  default     = "Standard_v2"
}

variable "minimum_capacity" {
  description = "The minimum capacity for the application gateway autoscale configuration"
  type        = number
  default     = 2
}

variable "maximum_capacity" {
  description = "The maximum capacity for the application gateway autoscale configuration"
  type        = number
  default     = 5
}

variable "container_app_fqdn" {
  description = "The FQDN of the container app"
  type        = string
  default     = "threatcomposer-app.greenwave-6d7b6ee1.uksouth.azurecontainerapps.io"
}

variable "cloudflare_zone_id" {
  description = "The ID of the Cloudflare zone"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the key vault"
  type        = string
  default     = "aamir-threatcomposer-kv"
}

variable "app_gateway_identity_name" {
  description = "The name of the application gateway identity"
  type        = string
  default     = "threatcomposer-app-gateway-identity"
}

variable "key_vault_secret_id" {
  description = "The ID of the key vault secret for the SSL certificate"
  type        = string
  default     = "https://aamir-threatcomposer-kv.vault.azure.net/secrets/threatcomposer-tls"
}
