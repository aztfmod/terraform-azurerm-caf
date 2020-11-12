global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
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
        nsg_key           = "sqlmi"
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

network_security_group_definition = {
  sqlmi = {
    nsg = [
      
    ]
  }
}

route_tables = {
  sqlmi1 = {
    name               = "sqlmi1"
    resource_group_key = "networking_region1"
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

mssql_managed_databases = {
  managed_db1 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db1"
    mi_server_key             = "sqlmi1"
  }
}