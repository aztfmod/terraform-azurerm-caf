global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
  inherit_tags = true
}

resource_groups = {
  new_rg = {
    name     = "RG1"
    location = "region1"
  }
}

search_services = {
  ss1 = {
    name               = "ss003"
    resource_group_key = "new_rg"
    region             = "region1"
    sku                = "standard"
    identity = {
      type = "SystemAssigned"
    }
    local_authentication_enabled = false
    # public_network_access_enabled = true
    # allowed_ips                   = ["13.478.57.73"]
  }
}