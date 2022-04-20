global_settings = {
  default_region = "region1"
  regions = {
    region1 = "australiaeast"
    region2 = "australiacentral"
  }
}

resource_groups = {
  sql_region1 = {
    name   = "sql-rg1"
    region = "region1"
  }
  sql_region2 = {
    name   = "sql-rg2"
    region = "region2"
  }
}



mssql_servers = {
  sql-server-rg1 = {
    name                         = "sql-server-rg1"
    region                       = "region1"
    resource_group_key           = "sql_region1"
    administrator_login          = "adminuser"
    administrator_login_password = "@dm1nu53r"
  }
  sql-server-rg2 = {
    name                         = "sql-server-rg2"
    region                       = "region2"
    resource_group_key           = "sql_region2"
    administrator_login          = "adminuser"
    administrator_login_password = "@dm1nu53r"
  }
}

mssql_databases = {
  db1-rg1 = {
    mssql_server_key   = "sql-server-rg1"
    resource_group_key = "sql_region1"
    name               = "db1rg1"
  }
  db2-rg1 = {
    mssql_server_key   = "sql-server-rg1"
    resource_group_key = "sql_region1"
    name               = "db2rg1"
  }
}

mssql_failover_groups = {
  failover_group1 = {
    resource_group_key = "sql_region1"
    name               = "failover-group"
    primary_server = {
      sql_server_key = "sql-server-rg1"
    }
    secondary_server = {
      sql_server_key = "sql-server-rg2"
    }
    databases = {
      db1-rg1 = {
        database_key = "db1-rg1"
      }
      db2-rg1 = {
        database_key = "db2-rg1"
      }
    }

    read_write_endpoint_failover_policy = {
      mode          = "Automatic"
      grace_minutes = 60
    }
  }
}