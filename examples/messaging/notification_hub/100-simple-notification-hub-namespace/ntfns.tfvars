landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations_sharedservices"
  level               = "level2"
  key                 = "caf_level2_notificationhubs"
  tfstates = {
    caf_foundations_sharedservices = {
      level   = "lower"
      tfstate = "caf_foundations_sharedservices.tfstate"
    }
    // caf_foundations_network = {
    //   level   = "lower"
    //   tfstate = "caf_foundations_network.tfstate"
    // }
    // caf_networking_vnets_network = {
    //   level   = "current"
    //   tfstate = "caf_networking_vnets_network.tfstate"
    // }

  }
}

global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus2"
    region2 = "centralus"
  }
}

resource_groups = {
  # Default to var.global_settings.default_region. You can overwrite it by setting the attribute region = "region2"
  nh_ns_examples = {
    name   = "notification_hub_examples"
    region = "region1"
  }
}

notification_hub_namespaces = {
  nh_ns1 = {
    name               = "nh1"
    resource_group_key = "nh_ns_examples"    
    region             = "region1"
    namespace_type     =  "NotificationHub"
    sku_name           = "Standard"
    enabled            = true                       # Optional
    tags = {
      "description"       = "notification hub"
    }
  }
}
