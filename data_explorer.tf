module "kusto_clusters" {
  source   = "./modules/databases/data_explorer/kusto_clusters"
  for_each = local.database.data_explorer.kusto_clusters

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}

  combined_resources = {
    vnets              = local.combined_objects_networking
    pips               = local.combined_objects_public_ip_addresses
    managed_identities = local.combined_objects_managed_identities
  }
}
output "kusto_clusters" {
  value = module.kusto_clusters
}

module "kusto_databases" {
  source   = "./modules/databases/data_explorer/kusto_databases"
  for_each = local.database.data_explorer.kusto_databases

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  cluster_name        = local.combined_objects_kusto_clusters[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.cluster_key].name
}
output "kusto_databases" {
  value = module.kusto_clusters
}

module "kusto_attached_database_configurations" {
  source   = "./modules/databases/data_explorer/kusto_attached_database_configurations"
  for_each = local.database.data_explorer.kusto_attached_database_configurations

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  cluster_name        = local.combined_objects_kusto_clusters[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.cluster.key].name
  cluster_resource_id = local.combined_objects_kusto_clusters[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.cluster.key].id
  database_name       = local.combined_objects_kusto_databases[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.database.key].name

}
output "kusto_attached_database_configurations" {
  value = module.kusto_attached_database_configurations
}
module "kusto_database_principal_assignments" {
  source   = "./modules/databases/data_explorer/kusto_database_principal_assignments"
  for_each = local.database.data_explorer.kusto_database_principal_assignments

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  cluster_name        = local.combined_objects_kusto_clusters[try(each.value.cluster.lz_key, local.client_config.landingzone_key)][each.value.cluster.key].name
  database_name       = local.combined_objects_kusto_databases[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.database.key].name
  principal_id        = local.combined_objects_azuread_service_principals[try(each.value.principal.lz_key, local.client_config.landingzone_key)][each.value.principal.key].object_id
  tenant_id           = local.combined_objects_azuread_service_principals[try(each.value.principal.lz_key, local.client_config.landingzone_key)][each.value.principal.key].tenant_id
}
output "kusto_database_principal_assignments" {
  value = module.kusto_database_principal_assignments
}
