global_settings = {
  default_region = "region1"
  regions = {
    region1 = "canadacentral"
  }
}

resource_groups = {
  rg1 = {
    name   = "container-app-001"
    region = "region1"
  }
}

diagnostic_log_analytics = {
  central_logs_region1 = {
    region             = "region1"
    name               = "logs"
    resource_group_key = "rg1"
  }
}

container_app_environments = {
  cae1 = {
    name               = "cont-app-env-001"
    region             = "region1"
    resource_group_key = "rg1"
    log_analytics_key  = "central_logs_region1"
  }
}

container_apps = {
  ca1 = {
    name                          = "nginx-app"
    container_app_environment_key = "cae1"
    resource_group_key            = "rg1"

    revision_mode = "Single"
    template = {
      container = {
        cont1 = {
          name   = "nginx"
          image  = "nginx:latest"
          cpu    = 0.5
          memory = "1Gi"
        }
      }
      min_replicas = 1
      max_replicas = 1
    }
  }
}
