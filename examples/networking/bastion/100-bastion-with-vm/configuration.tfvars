global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
  }
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

