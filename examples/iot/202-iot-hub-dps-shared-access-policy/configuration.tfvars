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
    name               = "iot_hub_1"
    region             = "region1"
    resource_group_key = "ioth_region1"
    sku = {
      name     = "S1"
      capacity = "1"
    }
  }
}

iot_dps_shared_access_policy = {
  iotdpssharedaccesspolicy1 = {
    name                = "iot_dps_shared_access_policy_1"
    iot_dps_key         = "iotdps1" 
    resource_group_key  = "ioth_region1"
    enrollment_write    = true
    enrollment_read     = true
  }
}
  