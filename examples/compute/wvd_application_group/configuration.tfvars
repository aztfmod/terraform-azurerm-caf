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

wvd_application_groups = {
  wvd_app1 = {
    resource_group_key  = "wvd_region1"
    host_pool_key       = "wvd_hp1"
    wvd_workspace_key   = "wvd_ws1"
    name                = "firsthp"
    friendly_name      = "FriendlyName"
    description        = "A description of my workspace"
    #Type of Virtual Desktop Application Group. Valid options are RemoteApp or Desktop.
    type          = "RemoteApp"
    
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
    #Option to specify the preferred Application Group type for the Virtual Desktop Host Pool. Valid options are None, Desktop or RailApplications.
    preferred_app_group_type = "RailApplications"
    maximum_sessions_allowed = 50
    load_balancer_type       = "DepthFirst"
    #Expiration value should be between 1 hour and 30 days.
    registration_info = {
      expiration_date = "2021-01-12T07:20:50.52Z"
    }
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


