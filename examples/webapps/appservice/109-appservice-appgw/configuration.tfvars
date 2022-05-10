global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
  }
}

resource_groups = {
  webapp_appgw = {
    name   = "webapp-appgw"
    region = "region1"
  }
}

vnets = {
  webapp_appgw = {
    resource_group_key = "webapp_appgw"
    region             = "region1"
    vnet = {
      name          = "webapp-appgw"
      address_space = ["10.1.0.0/24"]
    }
    specialsubnets = {}
    subnets = {
      appgw = {
        name              = "appgw"
        cidr              = ["10.1.0.0/28"]
        service_endpoints = ["Microsoft.Web"]
      }
      webapp = {
        name = "webapp"
        cidr = ["10.1.0.16/28"]
        delegation = {
          name               = "serverFarms"
          service_delegation = "Microsoft.Web/serverFarms"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action"
          ]
        }
      }
    }
  }
}

public_ip_addresses = {
  pip_appgw = {
    name               = "pip-appgw"
    resource_group_key = "webapp_appgw"
    sku                = "Standard"
    allocation_method  = "Static"
    ip_version         = "IPv4"
  }
}

application_gateways = {
  appgw_webapp = {
    resource_group_key = "webapp_appgw"
    name               = "appgw-webapp"
    vnet_key           = "webapp_appgw"
    subnet_key         = "appgw"
    sku_name           = "WAF_v2"
    sku_tier           = "WAF_v2"
    capacity = {
      autoscale = {
        minimum_scale_unit = 1
        maximum_scale_unit = 10
      }
    }

    front_end_ip_configurations = {
      public = {
        name          = "public"
        public_ip_key = "pip_appgw"
      }
      private = {
        name                          = "private"
        vnet_key                      = "webapp_appgw"
        subnet_key                    = "appgw"
        subnet_cidr_index             = 0
        private_ip_offset             = 4
        private_ip_address_allocation = "Static"
      }
    }

    front_end_ports = {
      80 = {
        name     = "http-80"
        port     = 80
        protocol = "Http"
      }
    }
  }
}

application_gateway_applications = {
  webapp_appgw_app = {
    application_gateway_key = "appgw_webapp"
    name                    = "webapp-appgw-app"

    listeners = {
      public_80 = {
        name                           = "public-80"
        front_end_ip_configuration_key = "public"
        front_end_port_key             = "80"
        request_routing_rule_key       = "default"
      }
    }

    request_routing_rules = {
      default = {
        rule_type = "Basic"
      }
    }

    backend_http_setting = {
      port                                = 443
      protocol                            = "Https"
      pick_host_name_from_backend_address = false
    }

    backend_pool = {
      app_services = {
        webapp_appgw = {
          key = "webapp_appgw"
        }
      }
    }
  }
}

app_service_plans = {
  asp_webapp_appgw = {
    resource_group_key = "webapp_appgw"
    name               = "asp-webapp-appgw"

    sku = {
      tier = "Standard"
      size = "S1"
    }
  }
}

app_services = {
  webapp_appgw = {
    resource_group_key   = "webapp_appgw"
    name                 = "webapp-appgw"
    app_service_plan_key = "asp_webapp_appgw"

    vnet_integration = {
      vnet_key   = "webapp_appgw"
      subnet_key = "webapp"
    }

    settings = {
      enabled = true
      site_config = {
        ip_restriction = [
          {
            name        = "appgw-access-by-service-tag"
            priority    = 100
            service_tag = "AzureCloud"
          },
          {
            name     = "appgw-access-by-subnet"
            priority = 101
            virtual_network_subnet = {
              vnet_key   = "webapp_appgw"
              subnet_key = "appgw"
            }
          }
        ]
      }
    }

    app_settings = {
      "WEBSITE_NODE_DEFAULT_VERSION" = "6.9.1"
    }
  }
}
