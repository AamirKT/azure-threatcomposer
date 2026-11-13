variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "static_ip" {
  description = "The static IP address for the DNS A record"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link to the private DNS zone"
  type        = string
}