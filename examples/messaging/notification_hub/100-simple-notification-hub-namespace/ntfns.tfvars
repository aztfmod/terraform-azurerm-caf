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
  nh_ns_namespace_rg = {
    name   = "nh_ns_namespace_rg"
    region = "region1"
  }
}

notification_hub_namespaces = {
  nh_ns1 = {
    name               = "nh1"
    resource_group_key = "nh_ns_namespace_rg"    
    region             = "region1"
    namespace_type     =  "NotificationHub"
    sku_name           = "Standard"
    enabled            = true                       # Optional
    tags = {
      "description"       = "notification hub namespace"
    }

    diagnostic_profiles = {
      diagnostics_storage_account = {
        name             = "diagnostics-storageaccount"
        definition_key   = "notification_hub_namespace"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      diagnostics_log_analytic = {
        name             = "diagnostics-loganalytics"
        definition_key   = "notification_hub_namespace"
        destination_type = "log_analytics"
        destination_key  = "eus_logs"
      }
      operationsevh = {
        name             = "diagnostics-eventhub"
        definition_key   = "notification_hub_namespace"
        destination_type = "event_hub"
        destination_key  = "eus_evh"
      }
    }
  }
}

notification_hubs = {
  nh1 = {
    name                                    = "nh1"
    resource_group_key                      = "nh_ns_namespace_rg"
    notification_hub_namespace_key          = "nh_ns1"
    region                                  = "region1"
    // apns_credential = {
    //   apns1   = {
    //     application_mode = ""
    //     bundle_id        = ""
    //     key_id           = ""
    //     team_id          = ""
    //     token            = ""        
    //   }
    // }
    // gcm_credential = {
    //   gcm1  = {
    //     api_key   = ""
    //   }
    // }

    tags = {
      "description"       = "notification hub"
    }
  }

}

notification_hub_authorization_rules = {
  rule1 = {
    resource_group_key                      = "nh_ns_namespace_rg"
    notification_hub_key                    = "nh1"
    notification_hub_namespace_key          = "nh_ns1"    
    name                                    = "nh-auth_rule1"
    listen                                  = true
    send                                    = true
    manage                                  = false
  }
}
