module "databricks_workspaces" {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  vnets               = local.combined_objects_networking
  aml                 = local.combined_objects_machine_learning
  diagnostics         = local.combined_diagnostics
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "databricks_workspaces" {
  value = module.databricks_workspaces

}

