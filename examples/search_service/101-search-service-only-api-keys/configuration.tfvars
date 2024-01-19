global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
  inherit_tags = true
  #   prefixes      = ["iac-shared"]
  #   random_length = 0
}

resource_groups = {
  new_rg = {
    name     = "RG1"
    location = "region1"
  }
}

search_services = {
  ss1 = {
    name               = "ss002"
    resource_group_key = "new_rg"
    region             = "region1"
    sku                = "basic"
  }
}