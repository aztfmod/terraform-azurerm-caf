landingzone = {
  backend_type        = "azurerm"
  global_settings_key = "launchpad"
  level               = "level0"
  key                 = "primary-mi"
  tfstates = {
    launchpad = {
      level   = "current"
      tfstate = "caf_launchpad.tfstate"
    }
  }
}

resource_groups = {
  networking_region1 = {
    name   = "mi-networking-rg1"
    region = "region1"
  }
  sqlmi_region1 = {
    name   = "sqlmi-rg1"
    region = "region1"
  }
}

vnets = {
  sqlmi_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "sqlmi-rg1"
      address_space = ["172.25.88.0/21"]
    }
    subnets = {
      sqlmi1 = {
        name              = "sqlmi1"
        cidr              = ["172.25.88.0/24"]
        nsg_key           = "sqlmi1"
        route_table_key   = "sqlmi1"
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

mssql_managed_instances = {
  sqlmi1 = {
    resource_group_key = "sqlmi_region1"
    name = "lz-sql-mi"
    sku = {
      name = "GP_Gen5"
    }
    administratorLogin = "adminuser"
    administratorLoginPassword = "@dm1nu53r@region1"

    //networking
    vnet_key  = "sqlmi_region1"
    subnet_key = "sqlmi1"

    storageSizeInGB = 32
    vCores          = 8
  }
}

mssql_managed_databases = {
  managed_db1 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db1"
    mi_key             = "sqlmi1"
  }
  managed_db2 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db2"
    mi_key             = "sqlmi1"
  }
}

network_security_group_definition = {
  sqlmi1 = {
    nsg = [
      {
        name                       = "allow-replication-from-mi2-5022",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-from-mi2-11000-11999",
        priority                   = "1100"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.96.0/24"
        destination_address_prefix = "172.25.88.0/24"
      },
      {
        name                       = "allow-replication-to-mi2-5022",
        priority                   = "1000"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "5022"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.96.0/24"
      },
      {
        name                       = "allow-replication-to-mi2-11000-11999",
        priority                   = "1100"
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "11000-11999"
        source_address_prefix      = "172.25.88.0/24"
        destination_address_prefix = "172.25.96.0/24"
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