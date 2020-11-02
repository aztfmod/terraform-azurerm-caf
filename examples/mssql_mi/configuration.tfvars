
resource_groups = {
  networking_region1 = {
    name   = "ase-networking"
    region = "region1"
  }
  sqlmi_region1 = {
    name   = "sqlmi"
    region = "region1"
  }
}

vnets = {
  sqlmi_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "sqlmi"
      address_space = ["172.25.88.0/21"]
    }
    specialsubnets = {}
    subnets = {
      sqlmi1 = {
        name              = "sqlmi1"
        cidr              = ["172.25.88.0/24"]
        nsg_key           = "sqlmi"
        delegation = {
          name = "sqlmidelegation"
          service_delegation = "Microsoft.Sql/managedInstances"
        }
      }
    }
  }
}

network_security_group_definition = {
  sqlmi = {
    nsg = [
      {
        name                       = "allow_tds_inbound",
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "1433"
        source_address_prefix      = "VirtualNetwork"
        destination_address_prefix = "*"
      },

    ]
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
    administratorLoginPassword = "@dm1nu53r@30102020"

    //networking
    vnet_key  = "sqlmi_region1"
    subnet_key = "sqlmi1"

    storageSizeInGB = 32
    vCores          = 8
  }
}
