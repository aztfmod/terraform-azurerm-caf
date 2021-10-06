landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "caf_foundations_sharedservices"
  level               = "level2"
  key                 = "caf_level2_eventgrid_topics"
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
  eventgrid_topics_rg = {
    name   = "eventgrid_topics_rg"
    region = "region1"
  }
}

eventgrid_topics = {
  evg_topic1 = {
    name               = "evg_topic1"
    resource_group_key = "eventgrid_topics_rg "    
    region             = "region1"
    // input_schema       = "CustomEventSchema"
    // input_mapping_fields =  {
    //   topic     = "test"
    //   subject   = "test"
    // }
    // input_mapping_default_values = {
    //   data_version  = "1.0"
    //   subject   = "test"
    // }
    inbound_ip_rule = {
      action    = "Allow"
      ip_mask   = "192.168.1.0/24"
    }
    tags = {
      "description" =  "test"
    }   
  }
}
