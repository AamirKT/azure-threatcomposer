resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space

  tags = {
    name = var.vnet_name
  }
}

resource "azurerm_subnet" "app_gateway" {
  name                 = "${var.vnet_name}-app_gateway-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_gateway_subnet_prefix]
}

resource "azurerm_subnet" "container_app" {
  name                 = "${var.vnet_name}-container_app-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.container_app_subnet_prefix]

  delegation {
    name = "${var.vnet_name}-container_app-delegation"

    service_delegation {
      name = "Microsoft.App/environments"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action"
      ]
    }
  }

}
