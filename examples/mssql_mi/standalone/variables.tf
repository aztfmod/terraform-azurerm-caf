
variable global_settings {
  default = {
    default_region = "region1"
    regions = {
      region1 = "southeastasia"
      region2 = "eastasia"
    }
  }
}
variable tags {
  default = null
  type    = map
}
variable resource_groups {
  default = null
}
variable network_security_group_definition {
  default = null
}
variable route_tables {
  default = {}
}
variable azurerm_routes {
  default = {}
}
variable vnets {
  default = {}
}
variable vnet_peerings {
  default = {}
}
variable mssql_managed_instances {
  default = {}
}
variable mssql_managed_instances_secondary {
  default = {}
}
variable mssql_managed_databases {
  default = {}
}
variable mssql_managed_databases_restore {
  default = {}
}
variable mssql_managed_databases_backup_ltr {
  default = {}
}
variable mssql_mi_failover_groups {
  default = {}
}
variable mssql_mi_administrators {
  default = {}
}
variable azuread_groups {
  default = {}
}
variable azuread_roles {
  default = {}
}