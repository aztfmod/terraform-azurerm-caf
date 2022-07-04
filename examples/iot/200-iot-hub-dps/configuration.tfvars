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

iot_hub_dps = {
  iotdps1 = {
    name               = "iotdps1"
    resource_group_key = "ioth_region1"
    allocation_policy  = "Hashed"
    sku = {
      name     = "S1"
      capacity = "1"
    }
  }
}
