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
