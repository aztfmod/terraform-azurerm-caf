module app_config {
  source   = "./modules/databases/app_config"
  for_each = local.database.app_config
  name     = each.value.name

  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  global_settings     = local.global_settings
  settings            = each.value
}

output app_config {
  value     = module.app_config
  sensitive = true
}