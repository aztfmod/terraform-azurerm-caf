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
    # Requires azurerm >= 2.92.0
    managed_resources_private_endpoints = {
      blob = {
        name               = "blob"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "blob"
          is_manual_connection = false
          subresource_names    = ["blob"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.blob.core.windows.net"]
        }
      }
      queue = {
        name               = "queue"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "queue"
          is_manual_connection = false
          subresource_names    = ["queue"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.queue.core.windows.net"]
        }
      }
      eventhub = {
        name               = "eventhub"
        resource_group_key = "rg1"
        vnet_key           = "vnet"
        subnet_key         = "servicesSubnetName"
        private_service_connection = {
          name                 = "eventhub"
          is_manual_connection = false
          subresource_names    = ["namespace"]
        }
        private_dns = {
          zone_group_name = "default"
          keys            = ["privatelink.servicebus.windows.net"]
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
    vnet_links = {
      vnet_link_pl = {
        name     = "vnet_link"
        vnet_key = "vnet"
        #lz_key   = "connectivity_private_dns_firewalls_prod"
      }
    }
  }
  "privatelink.purviewstudio.azure.com" = {
    name               = "privatelink.purviewstudio.azure.com"
    resource_group_key = "rg1"
    vnet_links = {
      vnet_link_pl = {
        name     = "vnet_link"
        vnet_key = "vnet"
        #lz_key   = "connectivity_private_dns_firewalls_prod"
      }
    }
  }
  "privatelink.queue.core.windows.net" = {
    name               = "privatelink.queue.core.windows.net"
    resource_group_key = "rg1"
    vnet_links = {
      vnet_link_pl = {
        name     = "vnet_link"
        vnet_key = "vnet"
        #lz_key   = "connectivity_private_dns_firewalls_prod"
      }
    }
  }
  "privatelink.blob.core.windows.net" = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "rg1"
    vnet_links = {
      vnet_link_pl = {
        name     = "vnet_link"
        vnet_key = "vnet"
        #lz_key   = "connectivity_private_dns_firewalls_prod"
      }
    }
  }
  "privatelink.servicebus.windows.net" = {
    name               = "privatelink.servicebus.windows.net"
    resource_group_key = "rg1"
    vnet_links = {
      vnet_link_pl = {
        name     = "vnet_link"
        vnet_key = "vnet"
        #lz_key   = "connectivity_private_dns_firewalls_prod"
      }
    }
  }
}
