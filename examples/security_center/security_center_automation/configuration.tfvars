global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  sec_center = {
    name = "sec-center"
  }
}

event_hub_namespaces = {
  evh1 = {
    name               = "evh1"
    resource_group_key = "sec_center"
    sku                = "Standard"
    region             = "region1"
  }
}

security_center_automation = {
  
}