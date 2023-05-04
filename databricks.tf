module "databricks_workspaces" {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  aml               = local.combined_objects_machine_learning
  client_config     = local.client_config
  diagnostics       = local.combined_diagnostics
  global_settings   = local.global_settings
  settings          = each.value
  vnets             = local.combined_objects_networking
  resource_groups   = local.combined_objects_resource_groups
  private_dns       = local.combined_objects_private_dns
  private_endpoints = try(each.value.private_endpoints, {})

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "databricks_workspaces" {
  value = module.databricks_workspaces

}

