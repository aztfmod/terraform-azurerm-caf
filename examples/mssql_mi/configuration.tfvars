
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
    subnets = {
      sqlmi1 = {
        name              = "sqlmi1"
        cidr              = ["172.25.88.0/24"]
        nsg_key           = "sqlmi"
        route_table_key   = "sqlmi"
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
    mi_key             = "sqlmi1"
  }
  # TODO: Remote source DB
  # managed_db_restore = {
  #   resource_group_key = "sqlmi_region1"
  #   name               = "lz-sql-managed-db-restore"
  #   mi_key             = "sqlmi1"
  #   createMode         = "PointInTimeRestore"
  #   sourceDatabaseId   = "/subscriptions/1d53e782-9f46-4720-b6b3-cff29106e9f6/resourceGroups/qcgz-rg-sqlmi-xfek/providers/Microsoft.Sql/managedInstances/qcgz-sql-lz-sql-mi-ilgj/databases/qcgz-sqldb-lz-sql-managed-db1-dvbu"
  #   restorePointInTime = "2020-11-05T09:03:00Z"
  # }
}