variable "vnet_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "app_gateway_subnet_prefix" {
  type = string
}

variable "container_app_subnet_prefix" {
  type = string
}
