resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_analytics_workspace_retention_in_days

  tags = {
    Name = var.log_analytics_workspace_name
  }
}

resource "azurerm_monitor_diagnostic_setting" "application_gateway_diagnostics" {
  name                       = "application-gateway-diagnostics"
  target_resource_id         = var.application_gateway_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  enabled_log {
    category = "ApplicationGatewayAccessLog"
  }
  enabled_log {
    category = "ApplicationGatewayPerformanceLog"
  }
  enabled_metric {
    category = "AllMetrics"
  }
}