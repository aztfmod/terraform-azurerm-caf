global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}


resource_groups = {
  rg1 = {
    name   = "example-sqldb"
    region = "region1"
  }
}

keyvaults = {
  kv1 = {
    name               = "examplekv"
    resource_group_key = "rg1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
      logged_in_aad_app = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}

managed_identities = {
  webapp_mi = {
    name               = "example_db_mi"
    resource_group_key = "rg1"
  }
}



azuread_groups = {
  sqlserver_admin = {
    name        = "example-sqlserver-admins"
    description = "Administrators of the sales SQL server."
    members = {
      user_principal_names = []

      # NOTE: To ensure DB users can be created, sqlserver admin needs to add the rover agent's system assigned identity object ID added
      # NOTE: since the authentication uses SQLCMD + DSN, UID cannot be supplied to the connection string, thus only system assigned identity is possible at this stage.      
      object_ids = [
        # Add object id of rover agent with system assigned identity here.
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


mssql_servers = {
  mssqlserver1 = {
    name                = "example-mssqlserver"
    region              = "region1"
    resource_group_key  = "rg1"
    version             = "12.0"
    administrator_login = "sqluseradmin"
    keyvault_key        = "kv1"
    connection_policy   = "Default"

    public_network_access_enabled = true

    azuread_administrator = {

      azuread_group_key = "sqlserver_admin"
    }
    identity = {
      type = "SystemAssigned"
    }
  }
}

mssql_databases = {

  mssql_db1 = {
    name               = "exampledb1"
    resource_group_key = "rg1"
    mssql_server_key   = "mssqlserver1"
    license_type       = "LicenseIncluded"
    max_size_gb        = 4
    sku_name           = "BC_Gen5_2"

    short_term_retention_policy = {
      retention_days = 8    # 7 to 35 days
    }

    long_term_retention_policy = {
      weekly_retention  = "P1W" # 1 to 520 in ISO 8601 format
      monthly_retention = "P1M" # 1 to 120 in ISO 8601 format
      yearly_retention  = "P1Y" # 1 to 10 in ISO 8601 format
      week_of_year      = 1 # 1 to 52
    }

  }
}