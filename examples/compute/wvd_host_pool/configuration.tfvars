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

wvd_host_pools = {
  wvd_hp1 = {
    resource_group_key  = "wvd_region1"
    name                = "firsthp"
    friendly_name      = "FriendlyName"
    description        = "A description of my workspace"
    validate_environment     = true
    type                     = "Pooled"
    maximum_sessions_allowed = 50
    load_balancer_type       = "DepthFirst"
    registration_info = {
      expiration_date = "2021-10-12T07:20:50.52Z"
    }
  }
}


