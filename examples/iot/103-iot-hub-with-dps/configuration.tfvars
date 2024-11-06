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
    name               = "iothub1"
    region             = "region1"
    resource_group_key = "ioth_region1"
    sku = {
      name     = "S1"
      capacity = "1"
    }
  }
}

iot_hub_shared_access_policy = {
  dps1 = {
    name = "dps1"
    iot_hub = {
      key = "iothub1"
    }
    resource_group_key = "ioth_region1"
    registry_read      = true
    registry_write     = true
    service_connect    = true
    device_connect     = true
  }
}

iot_hub_dps = {
  dps1 = {
    name               = "dps1"
    resource_group_key = "ioth_region1"
    allocation_policy  = "Hashed"
    sku = {
      name     = "S1"
      capacity = "1"
    }
    linked_hubs = {
      iothub1 = {
        iot_hub = {
          key = "iothub1"
        }
        shared_access_policy = {
          key = "dps1"
        }
      }
    }
  }
}

iot_dps_certificate = {
  cert1 = {
    name = "cert1"
    iot_hub_dps = {
      key = "dps1"
    }
    resource_group_key  = "ioth_region1"
    certificate_content = "examples/iot/103-iot-hub-with-dps/cert.pem"
  }
}

iot_dps_shared_access_policy = {
  policy1 = {
    name = "policy1"
    iot_hub_dps = {
      key = "dps1"
    }
    resource_group_key = "ioth_region1"
    enrollment_write   = true
    enrollment_read    = true
    registration_read  = true
  }
}
