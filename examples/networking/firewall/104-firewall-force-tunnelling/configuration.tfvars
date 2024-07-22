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
      AzureFirewallManagementSubnet = {
        name = "AzureFirewallManagementSubnet" # must be named AzureFirewallManagementSubnet
        cidr = ["10.2.2.0/24"]
      }
    }
    subnets = {
      # will attach UDR for internet traffic
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" # must be named AzureFirewallSubnet
        cidr = ["10.2.1.0/24"]
      }
    }
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
  pip2 = {
    name               = "pip2-name"
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
    management_ip_configuration = {
      ip2 = {
        name          = "pip2"
        public_ip_key = "pip2"
        # public_ip_address_id = "/subscriptions/xxxx/resourceGroups/xxxx/providers/Microsoft.Network/publicIPAddresses/xxxx"
        vnet_key   = "vnet1"
        subnet_key = "AzureFirewallManagementSubnet"
      }
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
        ["AzureFirewallApplicationRule", true, false, 0],
        ["AzureFirewallNetworkRule", true, false, 0],
        ["AzureFirewallDnsProxy", true, false, 0],
        ["AZFWApplicationRule", true, false, 0],
        ["AZFWApplicationRuleAggregation", true, false, 0],
        ["AZFWDnsQuery", true, false, 0],
        ["AZFWFatFlow", true, true, 0],
        ["AZFWFlowTrace", true, true, 0],
        ["AZFWFqdnResolveFailure", true, false, 0],
        ["AZFWIdpsSignature", true, false, 0],
        ["AZFWNatRule", true, false, 0],
        ["AZFWNatRuleAggregation", true, false, 0],
        ["AZFWNetworkRule", true, false, 0],
        ["AZFWNetworkRuleAggregation", true, false, 0],
        ["AZFWThreatIntel", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
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
