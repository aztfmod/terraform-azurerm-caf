global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  networking_region1 = {
    name   = "mi-networking-re1"
    region = "region1"
  }
  sqlmi_region1 = {
    name   = "sqlmi-re1"
    region = "region1"
  }
}

vnets = {
  sqlmi_region1 = {
    resource_group_key = "networking_region1"
    vnet = {
      name          = "sqlmi-rg1"
      address_space = ["172.25.88.0/21", "10.2.0.0/24"]
    }
    subnets = {
      sqlmi1 = {
        name            = "sqlmi1"
        cidr            = ["172.25.88.0/24"]
        nsg_key         = "sqlmi1"
        route_table_key = "sqlmi1"
        delegation = {
          name               = "sqlmidelegation"
          service_delegation = "Microsoft.Sql/managedInstances"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
          ]
        }
      }
      subnet02 = {
        name            = "subnet02"
        cidr            = ["10.2.0.0/24"]
        nsg_key         = "subnet02"
        route_table_key = "sqlmi1"
      }
    }
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
    name               = "lz-sql-mi"
    sku = {
      name = "GP_Gen5"
    }
    administratorLogin = "adminuser"
    # administratorLoginPassword = "@dm1nu53r@30102020"
    # if password not set, a random complex password will be created and stored in the keyvault
    # the secret value can be changed after the deployment if needed

    //networking
    networking = {
      vnet_key   = "sqlmi_region1"
      subnet_key = "sqlmi1"
    }
    keyvault_key = "sqlmi_rg1"

    storageSizeInGB = 32
    vCores          = 8
    private_endpoints = {
      privatelink-sqlmi = {
        name               = "pe-sqlmi1"
        vnet_key           = "sqlmi_region1"
        subnet_key         = "subnet02"
        resource_group_key = "sqlmi_region1"
        private_service_connection = {
          name                 = "conn-sqlmi1"
          is_manual_connection = false
          subresource_names    = ["managedInstance"]
        }
      }
    }
  }
}

mssql_managed_databases = {
  managed_db1 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db1"
    mi_server_key      = "sqlmi1"
  }
  managed_db2 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db2"
    mi_server_key      = "sqlmi1"
  }
}

mssql_managed_databases_backup_ltr = {
  sqlmi1 = {
    resource_group_key = "sqlmi_region1"
    mi_server_key      = "sqlmi1"
    database_key       = "managed_db1"

    weeklyRetention  = "P12W"
    monthlyRetention = "P12M"
    yearlyRetention  = "P5Y"
    weekOfYear       = 16
  }
}

azuread_roles = {
  mssql_managed_instances = {
    sqlmi1 = {
      roles = [
        "Directory Readers"
      ]
    }
  }
}

azuread_groups = {
  sql_mi_admins = {
    name        = "sql-mi-admins"
    description = "Administrators of the SQL MI."
    members = {
      user_principal_names = []
      object_ids = [
      ]
      group_keys             = []
      service_principal_keys = []
    }
    owners = {
      user_principal_names = [
      ]
      service_principal_keys = []
      object_ids             = []
    }
    prevent_duplicate_name = false
  }
}

## specify azuread_groups key OR you can import existing azuread group by using group OID as shown below

mssql_mi_administrators = {
  sqlmi1 = {
    resource_group_key = "sqlmi_region1"
    mi_server_key      = "sqlmi1"
    login              = "sqlmiadmin-khairi"

    # group key or existing group OID or upn supported
    azuread_group_key = "sql_mi_admins"
    # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"
    # user_principal_name = ""
  }
}

keyvaults = {
  sqlmi_rg1 = {
    name               = "sqlmirg1"
    resource_group_key = "sqlmi_region1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}