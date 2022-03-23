global_settings = {
  default_region = "region1"
  environment    = "test"
  regions = {
    region1 = "eastus"
    region2 = "centralus"
    region3 = "westeurope"
  }
}

resource_groups = {
  batch_region1 = {
    name = "batch"
  }
}

batch_accounts = {
  batch1 = {
    name                          = "batch"
    resource_group_key            = "batch_region1"
    storage_account_key           = "batch_region1"
    public_network_access_enabled = false
    private_endpoints = {
      pe1 = {
        name               = "batch"
        resource_group_key = "batch_region1"
        vnet_key           = "vnet1"
        subnet_key         = "pep"
        private_service_connection = {
          name                 = "batch"
          is_manual_connection = false
          subresource_names    = ["batchAccount"]
        }
        private_dns = {
          zone_group_name = "batch"
          keys            = ["batch_dns"]
        }
      }
    }
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "batch_region1"
    vnet = {
      name          = "batch"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {}
    subnets = {
      pep = {
        name                                           = "pep"
        cidr                                           = ["100.64.103.0/27"]
        service_endpoints                              = ["Microsoft.Storage"]
        enforce_private_link_endpoint_network_policies = "true"
      }
    }
  }
}

private_dns = {
  batch_dns = {
    name               = "privatelink.eastus.batch.azure.com"
    resource_group_key = "batch_region1"
    vnet_links = {
      vnlnk1 = {
        name     = "batch"
        vnet_key = "vnet1"
      }
    }
  }

  blob_dns = {
    name               = "privatelink.blob.core.windows.net"
    resource_group_key = "batch_region1"
    vnet_links = {
      vnlnk1 = {
        name     = "blob"
        vnet_key = "vnet1"
      }
    }
  }
}

storage_accounts = {
  batch_region1 = {
    name                     = "batch"
    resource_group_key       = "batch_region1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    network = {
      bypass         = ["AzureServices"]
      default_action = "Deny"
      subnets = {
        pep = {
          vnet_key   = "vnet1"
          subnet_key = "pep"
        }
      }
    }
    private_endpoints = {
      pe1 = {
        name               = "storage"
        resource_group_key = "batch_region1"
        vnet_key           = "vnet1"
        subnet_key         = "pep"
        private_service_connection = {
          name                 = "storage"
          is_manual_connection = false
          subresource_names    = ["blob"]
        }
        private_dns = {
          zone_group_name = "storage"
          keys            = ["blob_dns"]
        }
      }
    }
  }
}
