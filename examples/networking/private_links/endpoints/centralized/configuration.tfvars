global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
    region2 = "eastasia"
    region3 = "westeurope"
  }
}


resource_groups = {
  rg1 = {
    name   = "private-endpoints-rg"
    region = "region1"
  }
}
