global_settings = {
  default_region = "region1"
  regions = {
    region1 = "eastus"
  }
}
resource_groups = {
  rg1 = {
    name   = "dedicated-test"
    region = "region1"
  }
}


network_security_group_definition = {
  nsg1 = {
    nsg = [
      {
        name                       = "Storage",
        priority                   = "100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "Storage"
      },
      {
        name                       = "AzureDataLake",
        priority                   = "101"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureDataLake"
      },
      {
        name                       = "EventHub",
        priority                   = "102"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "EventHub"
      },
      {
        name                       = "EventHub2",
        priority                   = "103"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "5671"
        source_address_prefix      = "*"
        destination_address_prefix = "EventHub"
      },
      {
        name                       = "AzureMonitor",
        priority                   = "104"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureMonitor"
      },
      {
        name                       = "AzureActiveDirectory",
        priority                   = "105"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "AzureActiveDirectory"
      },
      {
        name                       = "Http",
        priority                   = "106"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "Internet"
      },
      {
        name                       = "Subnet",
        priority                   = "107"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "10.100.100.0/29"
      },
      # {
      #   name                       = "Custom",
      #   priority                   = "108"
      #   direction                  = "Outbound"
      #   access                     = "Allow"
      #   protocol                   = "tcp"
      #   source_port_range          = "*"
      #   destination_port_range     = "*"
      #   source_address_prefix      = "*"
      #   destination_address_prefix = "*"
      # },
    ]
  }
}
route_tables = {
  rt1 = {
    name               = "rt1"
    resource_group_key = "rg1"
  }
}
vnets = {
  vnet1 = {
    resource_group_key = "rg1"
    vnet = {
      name          = "vnet1"
      address_space = ["10.100.0.0/16"]
    }
    specialsubnets = {}
    subnets = {
      subnet1 = {
        name    = "subnet1"
        cidr    = ["10.100.100.0/24"]
        nsg_key = "nsg1"
        delegation = {
          name               = "kusto_clusters"
          service_delegation = "Microsoft.Kusto/clusters"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ]
        }
        route_table_key = "rt1"
      }
    }
  }
}
public_ip_addresses = {
  pip1 = {
    name                    = "pip1"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }

  pip2 = {
    name                    = "pip2"
    resource_group_key      = "rg1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"
  }
}
kusto_clusters = {
  kc1 = {
    name = "kustocluster"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name   = ""
    }
    region = "region1"

    sku = {
      name     = "Dev(No SLA)_Standard_E2a_v4"
      capacity = 1
    }
    virtual_network_configuration = {
      #lz_key = ""
      vnet_key   = "vnet1"
      subnet_key = "subnet1"
      #Enable Resource ID for the Subnet.
      engine_public_ip = {
        key = "pip1"
      }
      data_management_public_ip = {
        key = "pip2"
      }
    }
  }
}