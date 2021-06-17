module "databricks_workspaces" {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  vnets               = local.combined_objects_networking
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
}

output "databricks_workspaces" {
  value = module.databricks_workspaces

}

