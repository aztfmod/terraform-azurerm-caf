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

# requires azurerm provider >= 2.97.0
# iot_hub_certificate = {
#   csg1 = {
#     name                = "ioth_consumer_group_1"
#     iot_hub_key         = "iothub1"
#     is_verified         = true
#     certificate_content = "./path/to/cert"
#   }
# }
