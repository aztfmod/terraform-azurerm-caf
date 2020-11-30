module "caf" {
  source = "../../../"

  global_settings             = var.global_settings
  resource_groups             = var.resource_groups
  azuread_groups              = var.azuread_groups
  azuread_roles               = var.azuread_roles
  
  networking = {
    vnets                             = var.vnets
    vnet_peerings                     = var.vnet_peerings
    network_security_group_definition = var.network_security_group_definition
    route_tables                      = var.route_tables
    azurerm_routes                    = var.azurerm_routes
  }

  database = {
    mssql_managed_instances           = var.mssql_managed_instances
    mssql_managed_instances_secondary = var.mssql_managed_instances_secondary
    mssql_managed_databases           = var.mssql_managed_databases
    mssql_managed_databases_restore   = var.mssql_managed_databases_restore
    mssql_mi_failover_groups          = var.mssql_mi_failover_groups
    mssql_mi_administrators           = var.mssql_mi_administrators
  }
}