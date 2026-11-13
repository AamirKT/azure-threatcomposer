resource "azurerm_private_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name

  tags = {
    Name = var.dns_zone_name
  }
}

resource "azurerm_private_dns_a_record" "dns_a_record" {
  name                = "*"
  private_dns_zone_id = azurerm_private_dns_zone.dns_zone.id
  ttl                 = 300
  records             = [var.static_ip]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_private_link" {
  name                 = "${var.dns_zone_name}-link"
  virtual_network_id   = var.virtual_network_id
  private_dns_zone_id  = azurerm_private_dns_zone.dns_zone.id
  registration_enabled = false
}
