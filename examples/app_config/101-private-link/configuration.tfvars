global_settings = {
  default_region = "region1"
  regions = {
    region1 = "westus"
  }
}

provider_azurerm_features_template_deployment = {
  delete_nested_items_during_deletion = true
}

resource_groups = {
  rg1 = {
    name   = "rg1"
    region = "region1"
  }
}

app_config = {
  appconf1 = {
    name               = "appConf1"
    resource_group_key = "rg1"
    location           = "region1"
    tags = {
      project = "sales"
    }
    private_endpoints = {
      private-link1 = {
        name               = "appconfig-pe"
        vnet_key           = "vnet_security"
        subnet_key         = "private_link"
        resource_group_key = "rg1"
        private_service_connection = {
          name                 = "appconfig-pe"
          is_manual_connection = false
          subresource_names    = ["configurationStores"]
        }
      }
    }
  }
}

vnets = {
  vnet_security = {
    resource_group_key = "rg1"
    vnet = {
      name          = "default"
      address_space = ["10.1.100.0/24"]
    }
    subnets = {
      appconfig_endpoints = {
        name = "appconfig"
        cidr = ["10.1.100.64/26"]
      }
      private_link = {
        name                                           = "private-links"
        cidr                                           = ["10.1.100.128/26"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}