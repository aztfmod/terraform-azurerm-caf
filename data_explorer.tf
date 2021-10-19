module "kusto_clusters" {
  source   = "./modules/databases/data_explorer/kusto_clusters"
  for_each = local.database.data_explorer.kusto_clusters

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group.key].tags : {}

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

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

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  cluster_name = coalesce(
    try(local.combined_objects_kusto_clusters[try(each.value.kusto_cluster.lz_key, local.client_config.landingzone_key)][each.value.kusto_cluster.key].name, null),
    try(each.value.kusto_cluster.name, null)
  )


}
output "kusto_databases" {
  value = module.kusto_clusters
}

module "kusto_attached_database_configurations" {
  source   = "./modules/databases/data_explorer/kusto_attached_database_configurations"
  for_each = local.database.data_explorer.kusto_attached_database_configurations

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]


  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  cluster_name = coalesce(
    try(local.combined_objects_kusto_clusters[try(each.value.kusto_cluster.lz_key, local.client_config.landingzone_key)][each.value.kusto_cluster.key].name, null),
    try(each.value.kusto_cluster.name, null)
  )
  cluster_resource_id = coalesce(
    try(local.combined_objects_kusto_clusters[try(each.value.kusto_cluster.lz_key, local.client_config.landingzone_key)][each.value.kusto_cluster.key].id, null),
    try(each.value.kusto_cluster.id, null)
  )
  database_name = coalesce(
    try(local.combined_objects_kusto_databases[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.database.key].name, null),
    try(each.value.database.name, null)
  )
}

output "kusto_attached_database_configurations" {
  value = module.kusto_attached_database_configurations
}
module "kusto_database_principal_assignments" {
  source   = "./modules/databases/data_explorer/kusto_database_principal_assignments"
  for_each = local.database.data_explorer.kusto_database_principal_assignments

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group.key].location : local.global_settings.regions[each.value.region]
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  cluster_name = coalesce(
    try(local.combined_objects_kusto_clusters[try(each.value.kusto_cluster.lz_key, local.client_config.landingzone_key)][each.value.kusto_cluster.key].name, null),
    try(each.value.kusto_cluster.name, null)
  )
  database_name = coalesce(
    try(local.combined_objects_kusto_databases[try(each.value.database.lz_key, local.client_config.landingzone_key)][each.value.database.key].name, null),
    try(each.value.database.name, null)
  )
  principal_id = coalesce(
    try(local.combined_objects_azuread_service_principals[try(each.value.principal.lz_key, local.client_config.landingzone_key)][each.value.principal.key].object_id, null),
    try(each.value.principal.id, null)
  )
  tenant_id = coalesce(
    try(local.combined_objects_azuread_service_principals[try(each.value.principal.lz_key, local.client_config.landingzone_key)][each.value.principal.key].tenant_id, null),
    try(each.value.principal.tenant_id, null)
  )
}
output "kusto_database_principal_assignments" {
  value = module.kusto_database_principal_assignments
}
