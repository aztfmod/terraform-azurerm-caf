global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "japaneast"
  }
}

resource_groups = {
  networking_region1 = {
    name   = "sqlmi-networking-re1"
    region = "region1"
  }
  networking_region2 = {
    name   = "sqlmi-networking-re2"
    region = "region2"
  }
  sqlmi_region1 = {
    name   = "sqlmi-db-re1"
    region = "region1"
  }
  sqlmi_region2 = {
    name   = "sqlmi-db-re2"
    region = "region2"
  }
}


mssql_managed_instances = {
  sqlmi1 = {
    version = "v1"
    resource_group = {
      key = "sqlmi_region1"
    }
    name                = "sqlmi1"
    administrator_login = "adminuser"
    #administrator_login_password = "@dm1nu53r@30102020"
    ## if password not set, a random complex passwor will be created and stored in the keyvault
    ## the secret value can be changed after the deployment if needed
    ## When administrator_login_password use the following keyvault to store the password

    authentication_mode = "hybrid"
    # "aad_only", "hybrid"
    administrators = {
      # Set the group explicitly with object id (sid)
      # principal_type              = "Group"
      # sid                         = "a016736e-6c31-485e-a7d4-5b927171bd99"
      # login                       = "AAD DC Administrators"
      # tenant_id                    = "c2fe6ea2-ee35-4265-95f6-46e9a9b4ec96"

      # group key or existing group OID or upn supported
      azuread_group_key = "sql_mi_admins"
      login_username    = "AAD DC Administrators"
      # azuread_group_id   = "<specify existing azuread group's Object Id (OID) here>"

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
      type                  = "UserAssigned"
      managed_identity_keys = ["mi1"]

    }
    public_data_endpoint_enabled = false
    #service_principal
    sku = {
      name = "GP_Gen5"
    }
    backup_storage_redundancy = "LRS"
    storage_size_in_gb        = 32
    vcores                    = 4
    zone_redundant            = "false"
    transparent_data_encryption = {
      enabled = true
    }
  }
}


mssql_managed_databases = {
  managed_db1 = {
    version = "v1"

    name          = "lz-sql-managed-db1"
    mi_server_key = "sqlmi1"

    short_term_retention_days = 30

    long_term_retention_policy = {
      weekly_retention  = "P12W"
      monthly_retention = "P12M"
      yearly_retention  = "P5Y"
      week_of_year      = 16
    }

  }
  managed_db2 = {
    version       = "v1"
    name          = "lz-sql-managed-db2"
    mi_server_key = "sqlmi1"
  }
  # managed_db_ltr = {
  #   resource_group_key                = "sqlmi_region1"
  #   name                              = "lz-sql-managed-db-ltr"
  #   mi_server_key                     = "sqlmi1"
  #   createMode                        = "RestoreLongTermRetentionBackup"
  #   longTermRetentionBackupResourceId = "/subscriptions/1d53e782-9f46-4720-b6b3-cff29106e9f6/resourceGroups/whdz-rg-sqlmi-rg1/providers/Microsoft.Sql/locations/australiaeast/longTermRetentionManagedInstances/whdz-sql-lz-sql-mi/longTermRetentionDatabases/whdz-sqldb-lz-sql-managed-db1/longTermRetentionManagedInstanceBackups/7b19016e-3f85-46c0-b4bd-dd5c8f5624f3;132512472960000000"
  # }



}

managed_identities = {
  mi1 = {
    name               = "mssql-mi1"
    region             = "region1"
    resource_group_key = "sqlmi_region1"

  }
  mi2 = {
    name               = "mssql-m2"
    region             = "region2"
    resource_group_key = "sqlmi_region2"

  }
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



