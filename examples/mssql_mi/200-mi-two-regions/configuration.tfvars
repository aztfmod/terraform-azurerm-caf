global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  networking_region1 = {
    name   = "mi-networking-re1"
    region = "region1"
  }
  networking_region2 = {
    name   = "mi-networking-re2"
    region = "region2"
  }
  sqlmi_region1 = {
    name   = "sqlmi-re1"
    region = "region1"
  }
  sqlmi_region2 = {
    name   = "sqlmi-re2"
    region = "region2"
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
    }
  }
  sqlmi_region2 = {
    resource_group_key = "networking_region2"
    vnet = {
      name          = "sqlmi-re2"
      address_space = ["172.25.96.0/21"]
    }
    subnets = {
      sqlmi2 = {
        name            = "sqlmi2"
        cidr            = ["172.25.96.0/24"]
        nsg_key         = "sqlmi2"
        route_table_key = "sqlmi2"
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
    }
  }
}

route_tables = {
  sqlmi1 = {
    name               = "sqlmi1"
    resource_group_key = "networking_region1"
  }
  sqlmi2 = {
    name               = "sqlmi2"
    resource_group_key = "networking_region2"
  }
}

vnet_peerings_v1 = {

  # Establish a peering with the devops vnet
  mi_region1-TO-mi_region2 = {
    name = "mi_region1-TO-mi_region2"
    from = {
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
      vnet_key = "sqlmi_region1"
    }
    allow_virtual_network_access = true
    allow_forwarded_traffic      = false
    allow_gateway_transit        = false
    use_remote_gateways          = false
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
    # if password not set, a random complex passwor will be created and stored in the keyvault
    # the secret value can be changed after the deployment if needed

    //networking
    networking = {
      vnet_key   = "sqlmi_region1"
      subnet_key = "sqlmi1"
    }
    keyvault_key = "sqlmi_rg1"

    storageSizeInGB = 32
    vCores          = 4
  }
}

mssql_managed_instances_secondary = {
  sqlmi2 = {
    resource_group_key = "sqlmi_region2"
    name               = "lz-sql-mi-rg2"
    sku = {
      name = "GP_Gen5"
    }
    administratorLogin = "adminuser"
    # administratorLoginPassword = "@dm1nu53r@11112020"

    primary_server = {
      mi_server_key = "sqlmi1"
    }

    //networking
    networking = {
      vnet_key   = "sqlmi_region2"
      subnet_key = "sqlmi2"
    }
    keyvault_key = "sqlmi_rg1"

    storageSizeInGB = 32
    vCores          = 4
  }
}

mssql_managed_databases = {
  managed_db1 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db1"
    mi_server_key      = "sqlmi1"
    # retentionDays      = 20
    # collation          = "Greek_CS_AI"
  }
  managed_db2 = {
    resource_group_key = "sqlmi_region1"
    name               = "lz-sql-managed-db2"
    mi_server_key      = "sqlmi1"
  }
  # managed_db_ltr = {
  #   resource_group_key                = "sqlmi_region1"
  #   name                              = "lz-sql-managed-db-ltr"
  #   mi_server_key                     = "sqlmi1"
  #   createMode                        = "RestoreLongTermRetentionBackup"
  #   longTermRetentionBackupResourceId = "/subscriptions/1d53e782-9f46-4720-b6b3-cff29106e9f6/resourceGroups/whdz-rg-sqlmi-rg1/providers/Microsoft.Sql/locations/australiaeast/longTermRetentionManagedInstances/whdz-sql-lz-sql-mi/longTermRetentionDatabases/whdz-sqldb-lz-sql-managed-db1/longTermRetentionManagedInstanceBackups/7b19016e-3f85-46c0-b4bd-dd5c8f5624f3;132512472960000000"
  # }
}

# mssql_managed_databases_restore = {
#   managed_db_restore = {
#     resource_group_key  = "sqlmi_region1"
#     name                = "lz-sql-managed-db-restore"
#     mi_server_key       = "sqlmi1"
#     createMode          = "PointInTimeRestore"
#     source_database_key = "managed_db1"
#     restorePointInTime  = "2020-11-11T10:00:00Z"
#   }
# }

# mssql_managed_databases_backup_ltr = {
#   sqlmi1 = {
#     resource_group_key = "sqlmi_region1"
#     mi_server_key      = "sqlmi1"
#     database_key       = "managed_db1"

#     weeklyRetention  = "P12W"
#     monthlyRetention = "P12M"
#     yearlyRetention  = "P5Y"
#     weekOfYear       = 16
#   }
# }

mssql_mi_failover_groups = {
  failover-mi = {
    resource_group_key = "sqlmi_region1"
    name               = "failover-test"
    primary_server = {
      mi_server_key = "sqlmi1"
    }
    secondary_server = {
      mi_server_key = "sqlmi2"
    }
    readWriteEndpoint = {
      failoverPolicy                         = "Automatic"
      failoverWithDataLossGracePeriodMinutes = 60
    }
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
  mssql_managed_instances_secondary = {
    sqlmi2 = {
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

mssql_mi_administrators = {
  sqlmi1 = {
    resource_group_key = "sqlmi_region1"
    mi_server_key      = "sqlmi1"
    login              = "sqlmiadmin-khairi"
    azuread_group_key  = "sql_mi_admins"

    # group key or upn supported
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
  # tde_primary = {
  #   name               = "mi-tde-primary"
  #   resource_group_key = "sqlmi_region1"
  #   sku_name           = "standard"

  #   creation_policies = {
  #     logged_in_user = {
  #       key_permissions = ["get", "list", "update", "create", "import", "delete", "recover", "backup", "restore", "purge"]
  #     }
  #   }
  # }
  # tde_secondary = {
  #   name               = "mi-tde-secondary"
  #   resource_group_key = "sqlmi_region2"
  #   sku_name           = "standard"

  #   creation_policies = {
  #     logged_in_user = {
  #       key_permissions = ["get", "list", "update", "create", "import", "delete", "recover", "backup", "restore", "purge"]
  #     }
  #   }
  # }
}

# keyvault_access_policies = {
#   # A maximum of 16 access policies per keyvault
#   tde_primary = {
#     sqlmi1 = {
#       mssql_managed_instance_key = "sqlmi1"
#       key_permissions            = ["get", "unwrapKey", "wrapKey"]
#     }
#     sqlmi2 = {
#       mssql_managed_instance_secondary_key = "sqlmi2"
#       key_permissions                      = ["get", "unwrapKey", "wrapKey"]
#     }
#   }
#   tde_secondary = {
#     sqlmi1 = {
#       mssql_managed_instance_key = "sqlmi1"
#       key_permissions            = ["get", "unwrapKey", "wrapKey"]
#     }
#     sqlmi2 = {
#       mssql_managed_instance_secondary_key = "sqlmi2"
#       key_permissions                      = ["get", "unwrapKey", "wrapKey"]
#     }
#   }
# }

# keyvault_keys = {
#   tde_mi = {
#     keyvault_key = "tde_primary"
#     name         = "TDE"
#     key_type     = "RSA"
#     key_opts     = ["encrypt", "decrypt", "sign", "verify", "wrapKey", "unwrapKey"]
#     key_size     = 2048
#   }
# }

//TDE
# mssql_mi_secondary_tdes = {
#   sqlmi2 = {
#     resource_group_key     = "sqlmi_region2"
#     mi_server_key          = "sqlmi2"
#     keyvault_key_key       = "tde_mi"
#     secondary_keyvault_key = "tde_secondary"
#   }
# }

# mssql_mi_tdes = {
#   sqlmi1 = {
#     resource_group_key = "sqlmi_region1"
#     mi_server_key      = "sqlmi1"
#     keyvault_key_key   = "tde_mi"
#   }
# }