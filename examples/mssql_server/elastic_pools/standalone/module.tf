module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  storage_accounts = var.storage_accounts 
  keyvaults = var.keyvaults 
  azuread_roles = var.azuread_roles
  azuread_groups = var.azuread_groups

  networking = {
    vnets                             = var.vnets
    route_tables = var.route_tables
    network_security_group_definition = var.network_security_group_definition 
  }

  database = {
    mssql_databases = var.mssql_databases
    mssql_elastic_pools  = var.mssql_elastic_pools
    mssql_servers = var.mssql_servers
  }
  }
  
