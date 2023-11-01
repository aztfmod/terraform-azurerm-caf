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

vnets = {
  cae_re1 = {
    resource_group_key = "rg1"
    region             = "region1"
    vnet = {
      name          = "container-app-network"
      address_space = ["100.64.0.0/20"]
    }
    specialsubnets = {}
    subnets = {
      cae1 = {
        name    = "container-app-snet"
        cidr    = ["100.64.0.0/21"]
        nsg_key = "empty_nsg"
      }
    }

  }
}

network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {}
}

container_app_environments = {
  cae1 = {
    name               = "cont-app-env-001"
    region             = "region1"
    resource_group_key = "rg1"
    log_analytics_key  = "central_logs_region1"
    vnet = {
      vnet_key   = "cae_re1"
      subnet_key = "cae1"
    }
    internal_load_balancer_enabled = true

    tags = {
      environment = "testing"
    }
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
