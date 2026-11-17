resource "azurerm_public_ip" "application_gateway_ip" {
  name                = "${var.application_gateway_name}-ip"
  resource_group_name = var.resource_group_name
  location            = var.location

  depends_on = [azurerm_role_assignment.app_gateway_key_vault]

  allocation_method = "Static"
  sku               = "Standard"

  tags = {
    Name = "${var.application_gateway_name}-ip"
  }
}

resource "azurerm_application_gateway" "app_gateway" {
  name                = var.application_gateway_name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.app_gateway_identity.id]
  }

  sku {
    name = var.sku_name
    tier = var.tier
  }

  autoscale_configuration {
    min_capacity = var.minimum_capacity
    max_capacity = var.maximum_capacity
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = var.application_gateway_subnet_id
  }

  ssl_certificate {
    name                = "threatcomposer-tls"
    key_vault_secret_id = var.key_vault_secret_id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_port {
    name = "https-port"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "application-gateway-frontend-ip"
    public_ip_address_id = azurerm_public_ip.application_gateway_ip.id
  }

  backend_address_pool {
    name  = "container-apps-backend-pool"
    fqdns = [var.container_app_fqdn]
  }

  backend_http_settings {
    name                  = "container-apps-backend-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 30
    host_name             = var.container_app_fqdn
    probe_name            = "container-apps-probe"
  }

  probe {
    name                                      = "container-apps-probe"
    protocol                                  = "Https"
    path                                      = "/health.json"
    interval                                  = 30
    timeout                                   = 30
    unhealthy_threshold                       = 3
    pick_host_name_from_backend_http_settings = true

    match {
      status_code = ["200-399"]
    }
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "application-gateway-frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                        = "container-apps-routing-rule"
    priority                    = 100
    rule_type                   = "Basic"
    http_listener_name          = "http-listener"
    redirect_configuration_name = "http-to-https-redirect"
  }

  redirect_configuration {
    name                 = "http-to-https-redirect"
    redirect_type        = "Permanent"
    target_listener_name = "https-listener"
    include_path         = true
    include_query_string = true
  }

  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "application-gateway-frontend-ip"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = "threatcomposer-tls"
  }

  request_routing_rule {
    name                       = "container-apps-https-routing-rule"
    priority                   = 110
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "container-apps-backend-pool"
    backend_http_settings_name = "container-apps-backend-http-settings"
  }
}

resource "azurerm_user_assigned_identity" "app_gateway_identity" {
  name                = var.app_gateway_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Name = var.app_gateway_identity_name
  }
}

resource "azurerm_role_assignment" "app_gateway_key_vault" {
  principal_id         = azurerm_user_assigned_identity.app_gateway_identity.principal_id
  role_definition_name = "Key Vault Secrets User"
  scope                = var.key_vault_id
}