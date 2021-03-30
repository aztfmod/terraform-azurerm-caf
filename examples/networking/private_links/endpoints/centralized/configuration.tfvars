global_settings = {
  default_region = "region1"
  prefix         = null
  regions = {
    region1 = "southeastasia"
  }
}


resource_groups = {
  rg1 = {
    name   = "private-endpoints-rg"
    region = "region1"
  }
}
