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

iot_hub_consumer_groups = {
  csg = {
    name               = "ioth-consumer-group"
    resource_group_key = "ioth_region1"
    iot_hub = {
      key = "iothub1"
    }
    eventhub_endpoint_name = "events"
  }
}

iot_hub_certificate = {
  csg = {
    name               = "ioth-certificate"
    resource_group_key = "ioth_region1"
    iot_hub = {
      key = "iothub1"
    }
    is_verified         = true
    certificate_content = "examples/iot/100-iot-hub/cert.pem"
  }
}

iot_hub_shared_access_policy = {
  policy = {
    name = "policy"
    iot_hub = {
      key = "iothub1"
    }
    resource_group_key = "ioth_region1"
    registry_read      = true
    registry_write     = true
  }
}
