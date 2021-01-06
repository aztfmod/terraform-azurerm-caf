module "caf" {
  source = "../../../../../caf"
  global_settings    = var.global_settings
  tags               = var.tags
  resource_groups    = var.resource_groups
  azuread_roles = var.azuread_roles
  azuread_groups = var.azuread_groups

  networking = {
    vnets                             = var.vnets
    route_tables = var.route_tables
    network_security_group_definition = var.network_security_group_definition 
  }

  database = {
    mssql_managed_instances = var.mssql_managed_instances
    mssql_managed_databases  = var.mssql_managed_databases 
    mssql_mi_administrators = var.mssql_mi_administrators 
  }
  }
  
