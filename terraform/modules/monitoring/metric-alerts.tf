resource "azurerm_monitor_metric_alert" "application_gateway_unhealthy_backend_alert" {
  name                = "application-gateway-unhealthy-backend-alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_gateway_id]
  description         = "Triggers when application gateway has an unhealthy backend"
  severity            = 1
  enabled             = true
  frequency           = "PT1M"
  auto_mitigate       = true

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "UnhealthyHostCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0
  }

  target_resource_type     = "Microsoft.Network/applicationGateways"
  target_resource_location = var.location
}

resource "azurerm_monitor_metric_alert" "failed_request_alert" {
  name                = "application-gateway-failed-request-alert"
  resource_group_name = var.resource_group_name
  scopes              = [var.application_gateway_id]
  description         = "Triggers when application gateway has failed requests"
  severity            = 2
  enabled             = true
  frequency           = "PT1M"
  window_size         = "PT5M"
  auto_mitigate       = true

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "FailedRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = 0
  }

  target_resource_type     = "Microsoft.Network/applicationGateways"
  target_resource_location = var.location
}