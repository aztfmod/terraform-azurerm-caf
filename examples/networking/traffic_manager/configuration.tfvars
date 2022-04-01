global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  traffic_manager = {
    name = "trafficmanagervk"
  }
}

traffic_manager_profile = {
  parent = {
    name =  "trafficmanagervk"
    resource_group_key = "traffic_manager"
    profile_status = "Disabled"
    traffic_view_enabled = "false"
    max_return = "3"    
    dns_config = {
       relative_name = "trafficmanagervk"
       ttl = "90"
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
       name = "something"
    }
  }
  child = {
    name =  "trafficmanagervks"
    resource_group_key = "traffic_manager"
    profile_status = "Disabled"
    dns_config = {
       relative_name = "trafficmanagervks"
       ttl = "90"
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
       name = "something2"
    }
  }
}

traffic_manager_endpoint = {
  example_1 = {
      name                = "test"
      resource_group_key  = "traffic_manager"
      target              = "terraform.io"
      type                = "externalEndpoints"
      endpoint_status     = "Enabled"
      weight              = 100
      traffic_manager_profile = {
        key = "parent"
      }
      custom_header  = {
        name = "test"
        value = "host:contoso.com,customheader:contoso"
      }
  }
  example_2 = {
      name                = "test2"
      resource_group_key  = "traffic_manager"
      target              = "terraforms.io"
      type                = "externalEndpoints"
      endpoint_status     = "Disabled"
      weight              = 100
      traffic_manager_profile = {
        key = "parent"
      }
  }
  example_3 = {
      name                = "test3"
      resource_group_key  = "traffic_manager"
      target_resource_id  = "/subscriptions/158d9f92-ec1e-433e-8388-6f7157282c13/resourceGroups/ugly-rg-trafficmanagervk-gva/providers/Microsoft.Network/publicIPAddresses/ugly-pip-example_vm_pip1-smn"
      type                = "azureEndpoints"
      
      
      traffic_manager_profile = {
        key = "parent"
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

  }
}

traffic_manager_external_endpoint = {
  example_1 = {
        name       = "example-endpoint"
        weight     = 100
        target     = "www.example.com"
        traffic_manager_profile = {
        key = "child"
      }
  }
}