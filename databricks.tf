module databricks_workspaces {
  source   = "./modules/analytics/databricks_workspace"
  for_each = local.database.databricks_workspaces

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
<<<<<<< HEAD
  client_config       = local.client_config
=======
  client_config        = local.client_config
>>>>>>> 26c5af3f4a89bec1bca1fa9b304dd5dd5fe20aef
  settings            = each.value
  vnets               = local.combined_objects_networking
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output databricks_workspaces {
  value     = module.databricks_workspaces
  sensitive = true
}

