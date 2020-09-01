global_settings = {
  prefix           = "dsde"
  convention       = "cafrandom"
  default_location = "southeastasia"
  environment      = "demo"
}

resource_groups = {
  security = {
    name       = "launchpad-security"
    useprefix  = true
    max_length = 40
  }
}


keyvaults = {
  launchpad = {
    name               = "launchpad"
    resource_group_key = "security"
    region             = "southeastasia"
    convention         = "cafrandom"
    sku_name           = "standard"
    tags = {
      environment = "demo"
      tfstate     = "level0"
    }
  }
}