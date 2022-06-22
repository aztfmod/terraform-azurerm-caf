global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiasoutheast"
  }
}

resource_groups = {
  traffic_manager = {
    name   = "trafficmanager-1"
    region = "region1"
  }
  traffic_manager1 = {
    name   = "trafficmanager-2"
    region = "region2"
  }
}

traffic_manager_profile = {
  parent = {
    name                   = "trafficmanager-1"
    resource_group_key     = "traffic_manager"
    profile_status         = "Enabled"
    traffic_view_enabled   = "false"
    traffic_routing_method = "Weighted"
    max_return             = "3"
    dns_config = {
      relative_name = "trafficmanagervk"
      ttl           = "90"
    }
    monitor_config = {
      protocol                     = "HTTPS"
      port                         = 443
      path                         = "/"
      interval_in_seconds          = 30
      timeout_in_seconds           = 8
      tolerated_number_of_failures = 5
    }
    tags = {
      name = "trafficmanager-1"
    }
  }

  child = {
    name                   = "trafficmanager-2"
    resource_group_key     = "traffic_manager1"
    profile_status         = "Disabled"
    traffic_routing_method = "Weighted"
    dns_config = {
      relative_name = "trafficmanagervks"
      ttl           = "90"
    }
    monitor_config = {
      protocol                     = "HTTP"
      port                         = 80
      path                         = "/"
      interval_in_seconds          = 30
      timeout_in_seconds           = 8
      tolerated_number_of_failures = 5
    }
    tags = {
      name = "trafficmanager-2"
    }
  }
}


traffic_manager_external_endpoint = {
  example_1 = {
    name   = "example-external_endpoint"
    weight = 100
    target = "www.example.com"
    traffic_manager_profile = {
      key = "child"
      # lz_key = ""
    }
  }
}


traffic_manager_nested_endpoint = {
  example_1 = {
    name                    = "example-nested_endpoint"
    priority                = 100
    minimum_child_endpoints = 5
    weight                  = 100
    custom_header = {
      name  = "custom_header_1"
      value = "contoso.com"
    }
    traffic_manager_profile = {
      key = "child"
      # lz_key = ""
    }
    target_traffic_manager_profile = {
      key = "parent"
      # lz_key = ""
    }
  }
}


traffic_manager_azure_endpoint = {
  example_1 = {
    name   = "public_ip_address_example"
    weight = 100
    public_ip_address = {
      key = "example_vm_pip1_rg1"
      # lz_key = ""
    }
    traffic_manager_profile = {
      key = "parent"
      # lz_key = ""
    }
  }

  example_2 = {
    name   = "app_services_example"
    weight = 101
    app_services = {
      key = "webapp1"
      # lz_key = ""
    }
    traffic_manager_profile = {
      key = "child"
      # lz_key = ""
    }
  }

  example_3 = {
    name   = "app_services_slot_example"
    weight = 103
    app_services = {
      slot_key = "smoke_test"
      key      = "webapp2"
      # lz_key = ""
    }
    traffic_manager_profile = {
      key = "parent"
      # lz_key = ""
    }
  }


}


public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "traffic_manager"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
    domain_name_label       = "somednsname"
  }
}

app_service_plans = {
  asp1 = {
    resource_group_key = "traffic_manager1"
    name               = "asp-simple-caf1"

    sku = {
      tier = "Basic"
      size = "S1"
    }

  }
  asp2 = {
    resource_group_key = "traffic_manager1"
    name               = "asp-simple-caf2"

    sku = {
      tier = "Basic"
      size = "S1"
    }

  }
}

app_services = {
  webapp1 = {
    resource_group_key   = "traffic_manager1"
    name                 = "webapp-simple-caf1"
    app_service_plan_key = "asp1"

    settings = {
      enabled = true
    }
  }
  webapp2 = {
    resource_group_key   = "traffic_manager1"
    name                 = "webapp-simple-caf2"
    app_service_plan_key = "asp2"
    slots = {
      smoke_test = {
        name = "smoke-test1"
      }
      ab_test = {
        name = "AB-testing1"
      }
    }
    settings = {
      enabled = true
    }
  }
}
