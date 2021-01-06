module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups

  database = {
    mssql_databases = var.mssql_databases
    mssql_failover_groups  = var.mssql_failover_groups
    mssql_servers = var.mssql_servers
  }
  }
  
