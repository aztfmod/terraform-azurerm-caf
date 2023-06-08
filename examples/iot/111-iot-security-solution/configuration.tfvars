global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westeurope"
  }
}

resource_groups = {
  ioth_region1 = {
    name   = "iothub-rg1"
    region = "region1"
  }
}

iot_hub = {
  iothub1 = {
    name               = "iot_hub_1"
    region             = "region1"
    resource_group_key = "ioth_region1"
    sku = {
      name     = "S1"
      capacity = "1"
    }
  }
}

iot_security_solution = {
  csg1 = {
    name               = "iot-security-solution-1"
    resource_group_key = "ioth_region1"
    display_name       = "Iot Security Solution"
    iot_hub = {
      iothub1 = {
        key = "iothub1"
      }
    }
  }
}

iot_security_device_group = {
  csg1 = {
    name = "example-device-security-group"
    iot_hub = {
      key = "iothub1"
    }
    allow_rule = {
      connection_to_ips_not_allowed = ["10.0.0.0/24"]
    }
    range_rules = {
      rr1 = {
        type     = "ActiveConnectionsNotInAllowedRange"
        min      = 0
        max      = 30
        duration = "PT5M"
      }
    }
  }
}
