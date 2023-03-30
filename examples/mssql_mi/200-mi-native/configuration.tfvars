global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}

resource_groups = {
  networking_region1 = {
    name   = "mi-networking-re0"
    region = "region1"
  }
  sqlmi_region1 = {
    name   = "sqlmi-re0"
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
}

route_tables = {
  sqlmi1 = {
    name               = "sqlmi1"
    resource_group_key = "networking_region1"
  }
}

mssql_managed_instances = {
  # sqlmi0 = {
  #   resource_group_key = "sqlmi_region1"
  #   name               = "lz-sql-mi-v0"
  #   sku = {
  #     name = "GP_Gen5"
  #   }

  #   administratorLogin = "adminuser"
  #   #administrator_login_password = "@dm1nu53r@30102020"
  #   # if password not set, a random complex passwor will be created and stored in the keyvault
  #   # the secret value can be changed after the deployment if needed

  #   //networking
  #   networking = {
  #     vnet_key   = "sqlmi_region1"
  #     subnet_key = "sqlmi1"
  #   }
  #   keyvault_key = "sqlmi_rg1"

  #storageSizeInGB = 32
  #   vCores          = 4
  # }
  sqlmi1 = {
    version = "v1"
    resource_group = {
      key = "sqlmi_region1"
    }
    name                = "lz-sql-mi-aztf"
    administrator_login = "adminuser"
    #administrator_login_password = "@dm1nu53r@30102020"
    ## if password not set, a random complex passwor will be created and stored in the keyvault
    ## the secret value can be changed after the deployment if needed
    ## When administrator_login_password use the following keyvault to store the password

    authentication_mode = "sql_only"
    # "aad_only", "hybrid"
    administrators = {
      azuread_only_authentication = false
      principal_type              = "Group"
      sid                         = "a016736e-6c31-485e-a7d4-5b927171bd99"
      login                       = "AAD DC Administrators"
      tenantId                    = "c2fe6ea2-ee35-4265-95f6-46e9a9b4ec96"
    }
    #collation = "" */
    #dns_zone_partner=""
    #instance_pool_id=""
    keyvault = {
      key = "sqlmi_rg1"
    }
    license_type = "LicenseIncluded"
    # mi_create_mode = "d" #"Default" "PointInTimeRestore"
    #restore_point_in_time
    minimal_tls_version = "1.2"
    //networking
    networking = {
      vnet_key   = "sqlmi_region1"
      subnet_key = "sqlmi1"
    }
    #proxy_override               = "Redirect"
    identity = {
      type = "SystemAssigned"
    }
    public_data_endpoint_enabled = false
    #service_principal
    sku = {
      name = "GP_Gen5"
    }
    #sku = "ss"
    backup_storage_redundancy = "LRS"
    storage_size_in_gb        = 32
    vcores                    = 4
    zone_redundant            = "false"
    # transparent_data_encryption = {
    #   encryption_type  = "SMK"                                                                                          #SMK/CMK
    #   key_vault_key_id = "https://kvsandpit3d007f9f500190f.vault.azure.net/keys/mikey/7adec60d2b2c42a882397d732fc2aa24" # not needed for SMK
    # }
  }
}

# mssql_managed_instances_secondary = {
#   sqlmi2 = {
#     version = "v1"
#     resource_group = {
#       key = "sqlmi_region1"
#     }
#     name                = "lz-sql-mi-aztf-sec"
#     administrator_login = "adminuser"
#     #administrator_login_password = "@dm1nu53r@30102020"
#     ## if password not set, a random complex passwor will be created and stored in the keyvault
#     ## the secret value can be changed after the deployment if needed
#     ## When administrator_login_password use the following keyvault to store the password

#     authentication_mode = "sql_only"
#     # "aad_only", "hybrid"
#     administrators = {
#       azuread_only_authentication = false
#       principal_type              = "Group"
#       sid                         = "a016736e-6c31-485e-a7d4-5b927171bd99"
#       login                       = "AAD DC Administrators"
#       tenantId                    = "c2fe6ea2-ee35-4265-95f6-46e9a9b4ec96"
#     }
#     #collation = "" */
#     #dns_zone_partner=""
#     primary_server = {
#       mi_server_key = "sqlmi1"
#     }
#     #instance_pool_id=""
#     keyvault = {
#       key = "sqlmi_rg1"
#     }
#     license_type = "LicenseIncluded"
#     # mi_create_mode = "d" #"Default" "PointInTimeRestore"
#     #restore_point_in_time
#     minimal_tls_version = "1.2"
#     //networking
#     networking = {
#       vnet_key   = "sqlmi_region1"
#       subnet_key = "sqlmi1"
#     }
#     #proxy_override               = "Redirect"

#     public_data_endpoint_enabled = false
#     #service_principal
#     sku = {
#       name = "GP_Gen5"
#     }
#     #sku = "ss"
#     backup_storage_redundancy = "LRS"
#     storage_size_in_gb        = 32
#     vcores                    = 4
#     zone_redundant            = "false"
#     # transparent_data_encryption = {
#     #   encryption_type  = "SMK"                                                                                          #SMK/CMK
#     #   key_vault_key_id = "https://kvsandpit3d007f9f500190f.vault.azure.net/keys/mikey/7adec60d2b2c42a882397d732fc2aa24" # not needed for SMK
#     # }
#   }
# }

mssql_managed_databases = {
  managed_db1 = {
    version       = "v1"
    name          = "lz-sql-managed-db1"
    mi_server_key = "sqlmi1"

  }
}

# azuread_roles = {
#   mssql_managed_instances = {
#     sqlmi1 = {
#       roles = [
#         "Directory Readers"
#       ]
#     }
#   }
# }

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

# mssql_mi_failover_groups = {
#   failover-mi = {
#     version = "v1"
#     resource_group_key = "sqlmi_region1"
#     name               = "failover-test"
#     primary_server = {
#       mi_server_key = "sqlmi1"
#     }
#     secondary_server = {
#       mi_server_key = "sqlmi2"
#     }
#     readWriteEndpoint = {
#       failoverPolicy                         = "Automatic"
#       failoverWithDataLossGracePeriodMinutes = 60
#     }
#   }
# }
## specify azuread_groups key OR you can import existing azuread group by using group OID as shown below

# mssql_mi_administrators= {
#   version = "v1"
#   sqlmi1 = {
#     version            = "v1"
#     resource_group_key = "sqlmi_region1"
#     mi_server_key      = "sqlmi1"
#     login              = "sqlmiadmin-khairi"

#     # group key or existing group OID or upn supported
#     azuread_group_key = "sql_mi_admins"
#     # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"
#     # user_principal_name = ""
#   }
# }

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


