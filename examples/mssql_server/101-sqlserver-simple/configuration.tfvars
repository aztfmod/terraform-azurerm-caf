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
  sql-rg1 = {
    name                          = "sql-rg1"
    region                        = "region1"
    resource_group_key            = "sql_region1"
    administrator_login           = "sqladmin"
  }
}