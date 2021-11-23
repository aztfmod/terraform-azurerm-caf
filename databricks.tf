module "databricks_workspaces" {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  aml             = local.combined_objects_machine_learning
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  client_config   = local.client_config
  diagnostics     = local.combined_diagnostics
  global_settings = local.global_settings
  settings        = each.value
  vnets           = local.combined_objects_networking

  location = lookup(each.value, "region", null) == null ? local.resource_groups[
    coalesce(
      try(each.value.resource_group_key, null), #Kept for backwards compatibility
      try(each.value.resource_group.key, null)
    )
  ].location : local.global_settings.regions[each.value.region]

  resource_group_name = coalesce(
    try(local.resource_groups[each.value.resource_group_key].name, null), #Kept for backwards compatibility
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
}

output "databricks_workspaces" {
  value = module.databricks_workspaces

}

