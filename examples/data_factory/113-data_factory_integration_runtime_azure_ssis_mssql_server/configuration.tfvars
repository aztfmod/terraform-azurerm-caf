global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
  }
}
resource_groups = {
  rg1 = {
    name   = "databricks-re1"
    region = "region1"
  }
}


mssql_servers = {
  mssql1 = {
    name                = "sql-rg1"
    region              = "region1"
    resource_group_key  = "rg1"
    administrator_login = "sqladmin"
    keyvault_key        = "kv1"
    secret_name         = "sql-secret"
  }
}

keyvaults = {
  kv1 = {
    name               = "sqlrg1"
    resource_group_key = "rg1"
    sku_name           = "standard"

    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge"]
      }
    }
  }
}


data_factory = {
  df1 = {
    name = "example"
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
  }
}

data_factory_integration_runtime_azure_ssis = {
  dfiras1 = {
    name = "dfiras1"
    data_factory = {
      key = "df1"
    }
    resource_group = {
      key = "rg1"
      #lz_key = ""
      #name = ""
    }
    region = "region1"

    node_size = "Standard_D8_v3"

    cattalog_info = {
      server_endpoint = {
        mssql_server = {
          key = "mssql1"
        }
        keyvault = {
          keyvault_key = "kv1"
          secret_name  = "sql-secret"
        }
      }
    }
  }
}