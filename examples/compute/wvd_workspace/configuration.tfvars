global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "East US"
    
  }
}


resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  wvd_region1 = {
    name = "wvd"
  }
}

wvd_workspaces = {

  wvd_ws1 = {
    resource_group_key  = "wvd_region1"
    name                = "firstws"
    friendly_name      = "FriendlyName"
    description        = "A description of my workspace"
  }
}


