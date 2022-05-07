global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
    region2 = "westus"
  }
}

resource_groups = {
  vnet_hub_re1 = {
    name   = "vnet-hub-re1"
    region = "region1"
  }
}

vnets = {
  hub_re1 = {
    resource_group_key = "vnet_hub_re1"
    region             = "region1"
    vnet = {
      name          = "hub-re1"
      address_space = ["100.64.92.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.64.92.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["100.64.93.0/26"]
      }
    }
    subnets = {
      jumpbox = {
        name    = "jumpbox"
        cidr    = ["100.64.94.0/27"]
        nsg_key = "jumpbox"
      }
    }
  }
}

network_watchers = {
  network_watcher_1 = {
    name               = "nwwatcher_eastus"
    resource_group_key = "vnet_hub_re1"
    region             = "region1"
  }
}

diagnostics_destinations = {
  storage = {
    existing_logs_storage = {
      eastus = {
        storage_account_resource_id = "/subscriptions/b1e97734-6c8d-4926-8a2c-31b46eee4a5d/resourceGroups/rg-existing-storage/providers/Microsoft.Storage/storageAccounts/kabnstexistingeus"
      }
      westus = {
        storage_account_resource_id = "/subscriptions/e1406a71-5d6d-4d2e-8d5c-ecc4186bef34/resourceGroups/rg-existing-storage/providers/Microsoft.Storage/storageAccounts/kabnstexistingwus"
      }
    }
  }

  log_analytics = {
    existing_logs = {
      log_analytics_resource_id  = "/subscriptions/b1e97734-6c8d-4926-8a2c-31b46eee4a5d/resourcegroups/rg-existing-la/providers/microsoft.operationalinsights/workspaces/kabn-la-existing"
      log_analytics_location     = "eastus"
      log_analytics_workspace_id = "9ab25787-893b-4491-8bd8-4bbb91a16cbc"
    }
  }
}


network_security_group_definition = {
  jumpbox = {
    version            = 1
    resource_group_key = "vnet_hub_re1"
    name               = "jumpbox"

    flow_logs = {
      version = 2
      enabled = true

      network_watcher_key = "network_watcher_1"

      storage_account = {
        storage_account_destination = "existing_logs_storage"
        retention = {
          enabled = true
          days    = 30
        }
      }
      traffic_analytics = {
        enabled                             = true
        log_analytics_workspace_destination = "existing_logs"
        interval_in_minutes                 = "10"
      }
    }

    nsg = [
      {
        name                       = "ssh-inbound-22",
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      }
    ]
  }
}
