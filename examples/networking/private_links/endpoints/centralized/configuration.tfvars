global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
    region2 = "westeurope"
    region3 = "australiaeast"
  }
}


resource_groups = {
  rg1 = {
    name   = "private-endpoints-rg"
    region = "region1"
  }
}
