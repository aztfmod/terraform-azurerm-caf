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

iot_dps_certificate = {
  iothdpscert1 = {
    name                = "iot_dps_certificate_1"
    iot_dps_key         = "iothub1" 
    resource_group_key  = "ioth_region1"
    certificate_content = "iot/201-iot-hub-dps-certificate/cert.txt"
  }
}
