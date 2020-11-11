landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level0"
  key                 = "secondary-mi"
  tfstates = {
    launchpad = {
      level   = "current"
      tfstate = "caf_launchpad.tfstate"
    }
    primary-mi = {
      level   = "current"
      tfstate = "example_primary_mi.tfstate"
    }
  }
}

resource_groups = {
  networking_region2 = {
    name   = "mi-networking-rg2"
    region = "region2"
  }
  sqlmi_region2 = {
    name   = "sqlmi-rg2"
    region = "region2"
  }
}

vnets = {
  sqlmi_region2 = {
    resource_group_key = "networking_region2"
    vnet = {
      name          = "sqlmi-rg2"
      address_space = ["172.25.96.0/21"]
    }
    subnets = {
      sqlmi2 = {
        name              = "sqlmi2"
        cidr              = ["172.25.96.0/24"]
        nsg_key           = "sqlmi2"
        route_table_key   = "sqlmi2"
        delegation = {
          name = "sqlmidelegation"
          service_delegation = "Microsoft.Sql/managedInstances"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action", 
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", 
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
        }
      }
    }
  }
}

vnet_peerings = {

  # Establish a peering with the devops vnet
  mi_region1-TO-mi_region2 = {
    name = "mi_region1-TO-mi_region2"
    from = {
      lz_key   = "primary-mi"
      vnet_key = "sqlmi_region1"
    }
    to = {
      vnet_key = "sqlmi_region2"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }

  # Inbound peer with the devops vnet
  mi_region2-TO-mi_region1 = {
    name = "mi_region2-TO-mi_region1-TO-ase_region1"
    from = {
      vnet_key = "sqlmi_region2"
    }
    to = {
      lz_key   = "primary-mi"
      vnet_key = "sqlmi_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
  }
}


mssql_managed_instances = {
  sqlmi2 = {
    resource_group_key = "sqlmi_region2"
    name = "lz-sql-mi-rg2"
    sku = {
      name = "GP_Gen5"
    }
    administratorLogin = "adminuser"
    administratorLoginPassword = "@dm1nu53r@11112020"

    primary_server = {
      lz_key = "primary-mi"
      key    = "sqlmi1"
    }

    //networking
    vnet_key  = "sqlmi_region2"
    subnet_key = "sqlmi2"

    storageSizeInGB = 32
    vCores          = 8
  }
}

network_security_group_definition = {
  sqlmi1 = {
    nsg = [
      {
        name                       = "allow-replication-from-mi1-5022",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.96.0/24"
      },
      {
        name                       = "allow-replication-from-mi1-11000-11999",
        priority                   = "1100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.96.0/24"
      },
      {
        name                       = "allow-replication-to-mi1-5022",
        priority                   = "1000"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-to-mi1-11000-11999",
        priority                   = "1100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      }
    ]
  }
}

route_tables = {
  sqlmi1 = {
    name               = "sqlmi1"
    resource_group_key = "networking_region1"
  }
}