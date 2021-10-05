landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations_sharedservices"
  level               = "level2"
  key                 = "caf_level2_eventgrid_domains"
  tfstates = {
    caf_foundations_sharedservices = {
      level   = "lower"
      tfstate = "caf_foundations_sharedservices.tfstate"
    }
    // caf_foundations_network = {
    //   level   = "lower"
    //   tfstate = "caf_foundations_network.tfstate"
    // }
    caf_networking_vnets_network = {
      level   = "current"
      tfstate = "caf_networking_vnets_network.tfstate"
    }

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
  eventgrid_domains_rg = {
    name   = "eventgrid_domains_rg"
    region = "region1"
  }
}

eventgrid_domains = {
  evg_domain1 = {
    name               = "evg_domain1"
    resource_group_key = "eventgrid_domains_rg"    
    region             = "region1"
    public_network_access_enabled = false
    // input_schema       = "CustomEventSchema"
    // input_mapping_fields =  {
    //   topic     = "test"
    //   subject   = "test"
    // }
    // input_mapping_default_values = {
    //   data_version  = "1.0"
    //   subject   = "test"
    // }
    inbound_ip_rules = {
      rule1     = {
        action    = "Allow"
        ip_mask   = "192.168.1.0/24"
      }
      rule2     = {
        action    = "Allow"
        ip_mask   = "192.168.2.0/24"
      }
    }

    // private_endpoints = {
    //   # Require enforce_private_link_endpoint_network_policies set to true on the subnet
    //   eus_vnet_01 = {
    //     name               = "azeusvx1tstevgd001-pep-001"
    //     lz_key             = "caf_networking_vnets_network"
    //     vnet_key           = "eus_vnet_01"
    //     subnet_key         = "eus_vnet_01_snet_09"
    //     resource_group_key = "eventgrid_domains_rg"
      

    //     private_service_connection = {
    //       name                 = "azeusvx1tstevgd001-pep-001-psc"
    //       is_manual_connection = false
    //       subresource_names    = ["domain"]
    //     }

    //     private_dns = {
    //       lz_key          = "test_caf_networking_private_dns_identity"
    //       keys            = ["eventgrid_domain_01"]
    //       zone_group_name = "privatelink.eventgrid.azure.net"
    //       ttl             = 3600
    //     }
    //   }
    // }

    diagnostic_profiles = {
      diagnostics_storage_account = {
        name             = "diagnostics-storageaccount"
        definition_key   = "eventgrid_domain"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      diagnostics_log_analytic = {
        name             = "diagnostics-loganalytics"
        definition_key   = "eventgrid_domain"
        destination_type = "log_analytics"
        destination_key  = "eus_logs"
      }
      operationsevh = {
        name             = "diagnostics-eventhub"
        definition_key   = "eventgrid_domain"
        destination_type = "event_hub"
        destination_key  = "eus_evh"
      }
    }


    tags = {
      "description" =  "test"
    }   
  }
}
