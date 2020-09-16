global_settings = {
  prefix           = "dsde"
  default_location = "southeastasia"
  environment      = "demo"
}

resource_groups = {
  security = {
    name      = "launchpad-security"
    useprefix = true
  }
}


keyvaults = {
  launchpad = {
    name               = "launchpad"
    resource_group_key = "security"
    region             = "southeastasia"
    sku_name           = "standard"
    tags = {
      environment = "demo"
      tfstate     = "level0"
    }
  }
}