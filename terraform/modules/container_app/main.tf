resource "azurerm_container_app_environment" "container_app_env" {
  name                           = var.container_app_env_name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  infrastructure_subnet_id       = var.container_app_subnet_id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  logs_destination               = "log-analytics"
  internal_load_balancer_enabled = true
  zone_redundancy_enabled        = true

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }

  tags = {
    Name = var.container_app_env_name
  }
}

resource "azurerm_container_app" "container_app" {
  name                         = var.container_app_name
  container_app_environment_id = azurerm_container_app_environment.container_app_env.id
  resource_group_name          = var.resource_group_name
  revision_mode                = var.container_app_revision_mode
  workload_profile_name        = "Consumption"

  identity {
    type = "SystemAssigned"
  }

  registry {
    server   = var.acr_login_server
    identity = "system"
  }

  template {
    min_replicas = var.container_app_min_replicas
    max_replicas = var.container_app_max_replicas

    container {
      name   = var.container_app_name
      image  = var.container_app_image
      cpu    = var.container_app_cpu
      memory = var.container_app_memory

      readiness_probe {
        transport = "HTTP"
        port      = var.container_app_target_port
        path      = "/health.json"
      }

      liveness_probe {
        transport = "HTTP"
        port      = var.container_app_target_port
        path      = "/health.json"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = var.container_app_target_port
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = {
    Name = var.container_app_name
  }
}