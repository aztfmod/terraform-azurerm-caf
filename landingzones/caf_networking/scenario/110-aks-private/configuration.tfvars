level = "level2"

resource_groups = {
  vnet_rg1 = {
    name   = "vnet-rg1"
    region = "region1"
  }
  vnet_rg2 = {
    name   = "vnet-rg2"
    region = "region2"
  }
}

vnets = {
  hub_rg1 = {
    resource_group_key = "vnet_rg1"
    vnet = {
      name          = "hub"
      address_space = ["100.64.100.0/22"]
    }
    specialsubnets = {
      GatewaySubnet = {
        name = "GatewaySubnet" #Must be called GateWaySubnet in order to host a Virtual Network Gateway
        cidr = ["100.64.100.0/27"]
      }
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet 
        cidr = ["100.64.101.0/26"]
      }
    }
    subnets = {
      Active_Directory = {
        name            = "Active_Directory"
        cidr            = ["100.64.102.0/27"]
        route_table_key = "default_no_internet"
      }
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet 
        cidr    = ["100.64.103.0/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }
  }

  spoke_aks_rg1 = {
    resource_group_key = "vnet_rg1"
    vnet = {
      name          = "aks"
      address_space = ["100.64.48.0/22"]
    }
    specialsubnets = {}
    subnets = {
      aks_nodepool_system = {
        name            = "aks_nodepool_system"
        cidr            = ["100.64.48.0/24"]
        route_table_key = "default_to_firewall_rg1"
      }
      aks_nodepool_user1 = {
        name            = "aks_nodepool_user1"
        cidr            = ["100.64.49.0/24"]
        route_table_key = "default_to_firewall_rg1"
      }
      aks_nodepool_user2 = {
        name            = "aks_nodepool_user2"
        cidr            = ["100.64.50.0/24"]
        route_table_key = "default_to_firewall_rg1"
      }
    }
  }
}

vnet_peerings = {
  hub_rg1_TO_spoke_aks_rg1 = {
    from_key                     = "hub_rg1"
    to_key                       = "spoke_aks_rg1"
    name                         = "hub_rg1_TO_spoke_aks_rg1"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  spoke_aks_rg1_TO_hub_rg1 = {
    from_key                     = "spoke_aks_rg1"
    to_key                       = "hub_rg1"
    name                         = "spoke_aks_rg1_TO_hub_rg1"
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}

public_ip_addresses = {
  firewall_rg1 = {
    name                    = "egress-pip1"
    resource_group_key      = "vnet_rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      operation = {
        definition_key   = "public_ip_address"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

  }
}

azurerm_firewalls = {
  fw_rg1 = {
    name               = "egress"
    resource_group_key = "vnet_rg1"
    vnet_key           = "hub_rg1"
    public_ip_key      = "firewall_rg1"

    # you can setup up to 5 keys - vnet diganostic
    diagnostic_profiles = {
      operation = {
        definition_key   = "azurerm_firewall"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    azurerm_firewall_network_rule_collections     = ["aks"]
    azurerm_firewall_application_rule_collections = ["aks"]
  }
}

route_tables = {
  default_to_firewall_rg1 = {
    name               = "default_to_firewall_rg1"
    resource_group_key = "vnet_rg1"
  }
  default_no_internet = {
    name               = "default_no_internet"
    resource_group_key = "vnet_rg1"
  }
}

azurerm_routes = {
  no_internet = {
    name               = "no_internet"
    resource_group_key = "vnet_rg1"
    route_table_key    = "default_no_internet"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "None"
  }
  default_to_firewall_rg1 = {
    name               = "0-0-0-0-through-firewall-rg1"
    resource_group_key = "vnet_rg1"
    route_table_key    = "default_to_firewall_rg1"
    address_prefix     = "0.0.0.0/0"
    next_hop_type      = "VirtualAppliance"

    # To be set when next_hop_type = "VirtualAppliance"
    private_ip_keys = {
      azurerm_firewall = {
        key             = "fw_rg1"
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
  aks = {
    name     = "aks"
    action   = "Allow"
    priority = 150
    ruleset = [
      {
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
      {
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
    ]
  }
}

azurerm_firewall_application_rule_collection_definition = {
  aks = {
    name     = "aks"
    action   = "Allow"
    priority = 100
    ruleset = [
      {
        name = "aks"
        source_addresses = [
          "*",
        ]
        fqdn_tags = [
          "AzureKubernetesService",
        ]
      },
      {
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
    ]
  }
}

#
# Definition of the networking security groups
#
network_security_group_definition = {
  # This entry is applied to all subnets with no NSG defined
  empty_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }
  }

  azure_bastion_nsg = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
      }
    }

    nsg = [
      {
        name                       = "bastion-in-allow",
        priority                   = "100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-control-in-allow-443",
        priority                   = "120"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "135"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "Kerberos-password-change",
        priority                   = "121"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "4443"
        source_address_prefix      = "GatewayManager"
        destination_address_prefix = "*"
      },
      {
        name                       = "bastion-vnet-out-allow-22",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-vnet-out-allow-3389",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "VirtualNetwork"
      },
      {
        name                       = "bastion-azure-out-allow",
        priority                   = "120"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureCloud"
      }
    ]
  }

  jumphost = {

    diagnostic_profiles = {
      nsg = {
        definition_key   = "network_security_group"
        destination_type = "storage"
        destination_key  = "all_regions"
      }
      operations = {
        name             = "operations"
        definition_key   = "network_security_group"
        destination_type = "log_analytics"
        destination_key  = "central_logs"
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
      },
    ]
  }

}


#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  azurerm_firewall = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["AzureFirewallApplicationRule", true, true, 7],
        ["AzureFirewallNetworkRule", true, true, 7],
        ["AzureFirewallDnsProxy", true, true, 7],
      ]
      metric = [
        ["AllMetrics", true, true, 7],
      ]
    }
  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
        ["DDoSProtectionNotifications", true, true, 7],
        ["DDoSMitigationFlowLogs", true, true, 7],
        ["DDoSMitigationReports", true, true, 7],
      ]
      metric = [
        ["AllMetrics", true, true, 7],
      ]
    }
  }

}