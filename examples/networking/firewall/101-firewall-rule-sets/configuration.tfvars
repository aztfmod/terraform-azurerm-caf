global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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
    name               = "pip1"
    resource_group_key = "test"
    sku                = "Standard"  # must be 'Standard' SKU
    allocation_method = "Static"  # must be Static
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}

azurerm_firewalls = {
  firewall1 = {
    name = "test-firewall"
    resource_group_key =  "test"
    vnet_key = "vnet1"
    public_ip_key = "pip1"
    azurerm_firewall_network_rule_collections     = ["network_rule1"]
    azurerm_firewall_application_rule_collections = ["application_rule1"]
  }
}


route_tables = {
  to_firewall = {
    name               = "to_firewall"
    resource_group_key = "test"
  }
  no_internet = {
    name               = "no_internet"
    resource_group_key = "test"
  }
}

azurerm_routes = {
  no_internet = {
    name               = "no_internet"
    resource_group_key = "test"
    route_table_key    = "no_internet"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "None"
  }
  to_firewall = {
    name               = "to_firewall"
    resource_group_key = "test"
    route_table_key    = "to_firewall"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "VirtualAppliance"

    # To be set when next_hop_type = "VirtualAppliance"
    private_ip_keys = {
      azurerm_firewall = {
        key             = "firewall1"
        interface_index = 0
      }
      # virtual_machine = {
      #   key = ""
      #   nic_key = ""
      # }
    }
  }
}

azurerm_firewall_network_rule_collection_definition = {
  network_rule1= {
    name     = "network_rule1"
    action   = "Allow"
    priority = 150
    ruleset = {
      ntp = {
        name = "ntp"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "123",
        ]
        destination_addresses = [
          "91.189.89.198", "91.189.91.157", "91.189.94.4", "91.189.89.199"
        ]
        protocols = [
          "UDP",
        ]
      },
      monitor = {
        name = "monitor"
        source_addresses = [
          "*",
        ]
        destination_ports = [
          "443",
        ]
        destination_addresses = [
          "AzureMonitor"
        ]
        protocols = [
          "TCP",
        ]
      },
    }
  }
}

azurerm_firewall_application_rule_collection_definition = {
  application_rule1 = {
    name     = "application_rule"
    action   = "Allow"
    priority = 100
    ruleset = {
      aks = {
        name = "aks"
        source_addresses = [
          "*",
        ]
        fqdn_tags = [
          "AzureKubernetesService",
        ]
      },
      ubuntu = {
        name = "ubuntu"
        source_addresses = [
          "*",
        ]
        target_fqdns = [
          "security.ubuntu.com", "azure.archive.ubuntu.com", "changelogs.ubuntu.com"
        ]
        protocol = {
          http = {
            port = "80"
            type = "Http"
          }
        }
      },
    }
  }
}