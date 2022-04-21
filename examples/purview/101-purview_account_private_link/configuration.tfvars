global_settings = {
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}
resource_groups = {
  rg1 = {
    name = "rg1"
  }
}

purview_accounts = {
  pva1 = {
    name                        = "pva1"
    region                      = "region1"
    public_network_enabled      = false
    managed_resource_group_name = "rg1-purview"
    resource_group = {
      key = "rg1"
    }
    private_endpoints = {
      account = {
        name               = "account"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "account"
          is_manual_connection = false
          subresource_names    = ["account"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.purview.azure.com"]
        }
      }
      portal = {
        name               = "portal"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "portal"
          is_manual_connection = false
          subresource_names    = ["portal"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.purviewstudio.azure.com"]
        }
      }
    }
  }
}

keyvaults = {
  kv = {
    name                      = "kv"
    resource_group_key        = "rg1"
    sku_name                  = "standard"
    enable_rbac_authorization = true
    soft_delete_enabled       = true
    purge_protection_enabled  = true
    tags = {
      env = "Standalone"
    }
    network = {
      default_action = "Deny"
      bypass         = "AzureServices"
      ip_rules       = []
      subnets = {
        servicesSubnetName = {
          vnet_key   = "vnet"
          subnet_key = "servicesSubnetName"
        }
      }
    }
    private_endpoints = {
      vault = {
        name               = "vault"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "vault"
          is_manual_connection = false
          subresource_names    = ["vault"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.vaultcore.azure.net"]
        }
      }
    }
  }
}


role_mapping = {
  built_in_role_mapping = {
    keyvaults = {
      kv = {
        "Key Vault Administrator" = {
          purview_accounts = {
            keys = ["pva1"]
          }
        }
      }
    }
  }
}

network_security_group_definition = {
  nsg = {
    version            = 1
    resource_group_key = "rg1"
    name               = "nsg"
  }
}

vnets = {
  vnet = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vnet"
      address_space = ["10.1.0.0/16", "10.45.0.0/16"]
    }
    subnets = {
      servicesSubnetName = {
        name                                           = "servicesSubnetName"
        cidr                                           = ["10.1.0.0/24"]
        nsg_key                                        = "nsg"
        service_endpoints                              = ["Microsoft.KeyVault"]
        enforce_private_link_endpoint_network_policies = true
      }
    }
  }
}

private_dns = {
  "privatelink.purview.azure.com" = {
    name               = "privatelink.purview.azure.com"
    resource_group_key = "rg1"
  }
  "privatelink.purviewstudio.azure.com" = {
    name               = "privatelink.purviewstudio.azure.com"
    resource_group_key = "rg1"
  }
  "privatelink.vaultcore.azure.net" = {
    name               = "privatelink.vaultcore.azure.net"
    resource_group_key = "rg1"
  }
}