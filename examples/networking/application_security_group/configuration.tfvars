global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  rg1 = {
    name   = "app-sec-group"
    region = "region1"
  }
}

application_security_groups = {
  ase = {
    name = "appsecgw1"
    resource_group_key = "rg1"
    
  }
}