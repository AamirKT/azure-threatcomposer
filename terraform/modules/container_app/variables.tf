variable "resource_group_name" {
  description = "The name of the resource group for the container app environment"
  type        = string
}
variable "container_app_subnet_id" {
  description = "The ID of the subnet for the container app environment"
  type        = string
}
variable "location" {
  description = "The location of the container app environment"
  type        = string
}

variable "container_app_env_name" {
  description = "The name of the container apps environment"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace"
  type        = string
}
variable "container_app_name" {
  description = "The name of the container app"
  type        = string
}
variable "container_app_image" {
  description = "The container image for the container app"
  type        = string
}
variable "container_app_cpu" {
  description = "The CPU allocation for the container app"
  type        = string
}
variable "container_app_memory" {
  description = "The memory allocation for the container app"
  type        = string
}
variable "container_app_min_replicas" {
  description = "The minimum number of replicas for the container app"
  type        = number
}
variable "container_app_max_replicas" {
  description = "The maximum number of replicas for the container app"
  type        = number
}
variable "container_app_target_port" {
  description = "The target port for the container app ingress"
  type        = number
}

variable "container_app_revision_mode" {
  description = "The revision mode for the container app"
  type        = string
}

variable "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry"
  type        = string
}