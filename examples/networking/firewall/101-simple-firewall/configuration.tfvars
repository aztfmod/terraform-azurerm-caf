global_settings = {
  default_region = "region1"
  regions = {
    region1 = "northeurope"
  }
}

resource_groups = {
  test = {
    name = "test"
  }
}

vnets = {
  vnet1 = {
    resource_group_key = "test"
    vnet = {
      name          = "test-vn"
      address_space = ["10.2.0.0/16"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" # must be named AzureFirewallSubnet
        cidr = ["10.2.1.0/24"]
      }
    }
    subnets = {}
  }
}

public_ip_addresses = {
  pip1 = {
    name               = "pip1-name"
    resource_group_key = "test"
    sku                = "Standard" # must be 'Standard' SKU
    # Standard SKU Public IP Addresses that do not specify a zone are zone redundant by default.
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

azurerm_firewalls = {
  firewall1 = {
    name               = "test-firewall"
    resource_group_key = "test"
    vnet_key           = "vnet1"
    sku_tier           = "Standard"
    zones              = ["1", "2", "3"]
    public_ips = {
      ip1 = {
        name          = "pip1"
        public_ip_key = "pip1"
        vnet_key      = "vnet1"
        subnet_key    = "AzureFirewallSubnet"
        # lz_key = "lz_key"
      }
      # ip2 = {
      #   name = "pip2"
      #   public_ip_id = "azure_resource_id"
      #   subnet_id = "azure_resource_id"
      # }
    }
    diagnostic_profiles = {
      central_logs_region1 = {
        definition_key   = "azurerm_firewall"
        destination_type = "event_hub"
        destination_key  = "central_logs"
      }
    }
  }
}

diagnostics_definition = {
  azurerm_firewall = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureFirewallApplicationRule", true, false, 7],
        ["AzureFirewallNetworkRule", true, false, 7],
        ["AzureFirewallDnsProxy", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }
}

diagnostic_event_hub_namespaces = {
  central_logs_region1 = {
    name               = "logs"
    resource_group_key = "test"
    sku                = "Standard"
    region             = "region1"
  }
}

diagnostics_destinations = {
  # Storage keys must reference the azure region name
  # For storage, reference "all_regions" and we will send the logs to the storage account
  # in the region of the deployment


  event_hub_namespaces = {
    central_logs = {
      event_hub_namespace_key = "central_logs_region1"
    }
  }
}
