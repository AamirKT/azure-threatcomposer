output "dns_zone_id" {
  value = azurerm_private_dns_zone.dns_zone.id
}

output "dns_private_a_record_id" {
  value = azurerm_private_dns_a_record.dns_a_record.id
}

output "dns_private_link_id" {
  value = azurerm_private_dns_zone_virtual_network_link.dns_private_link.id
}