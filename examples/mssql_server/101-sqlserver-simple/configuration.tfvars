global_settings = {
  default_region = "region1"
  regions = {
    region1 = "southeastasia"
  }
}

resource_groups = {
  sql_region1 = {
    name   = "sql-rg1"
    region = "region1"
  }
}

mssql_servers = {
  sql_rg1 = {
    name                = "sql-rg1"
    region              = "region1"
    resource_group_key  = "sql_region1"
    administrator_login = "sqladmin"
  }
}

keyvaults = {
  sql_rg1 = {
    name               = "sqlrg1"
    resource_group_key = "sql_region1"
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

#need to place dynamic secrets module outside caf module to pass the objects
# dynamic_keyvault_secrets = {
#   sql_rg1 = {
#     sql_username = {
#       output_key    = "mssql_servers"
#       resource_key  = "sql_rg1"
#       attribute_key = "administrator_login"
#       secret_name   = "sql-rg1-username"
#     }
#     sql_password = {
#       output_key    = "mssql_servers"
#       resource_key  = "sql_rg1"
#       attribute_key = "administrator_login_password"
#       secret_name   = "sql-rg1-password"
#     }
#   }
# }