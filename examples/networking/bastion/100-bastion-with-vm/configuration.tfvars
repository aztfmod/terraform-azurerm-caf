global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
    region2 = "centralus"
  }
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

