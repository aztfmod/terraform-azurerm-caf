module databricks_workspaces {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value
  vnet                = lookup(each.value.custom_parameters, "remote_tfstate", null) == null ? module.networking[each.value.custom_parameters.vnet_key] : null
  use_msi             = var.use_msi
  tfstates            = var.tfstates
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output databricks_workspaces {
  value     = module.databricks_workspaces
  sensitive = true
}

