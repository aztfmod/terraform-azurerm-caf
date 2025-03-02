global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  automation = {
    name = "automation"
  }
}

automations = {
  auto1 = {
    name               = "automation"
    sku                = "Basic"
    resource_group_key = "automation"
  }
}

automation_powershell72_module = {
  module1 = {
    name                   = "Az.ResourceGraph"
    automation_account_key = "auto1"
    module_link = {
      uri = "https://www.powershellgallery.com/api/v2/package/Az.ResourceGraph/1.0.0"
    }
  }
}