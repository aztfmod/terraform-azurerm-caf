
output "mssql_elastic_pools" {
  value = module.mssql_elastic_pools

}

module "mssql_elastic_pools" {
  source = "./modules/databases/mssql_elastic_pool"
  for_each = {
    for key, value in local.database.mssql_elastic_pools : key => value
    if try(value.lz_key, null) == null
  }

  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  server_name         = module.mssql_servers[each.value.mssql_server_key].name
}

module "mssql_elastic_pools_remote" {
  source = "./modules/databases/mssql_elastic_pool"
  for_each = {
    for key, value in local.database.mssql_elastic_pools : key => value
    if try(value.lz_key, null) != null
  }

  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  server_name         = var.remote_objects.mssql_servers[each.value.lz_key][each.value.mssql_server_key].name
}
