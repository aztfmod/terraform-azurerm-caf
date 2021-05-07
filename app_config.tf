module "app_config" {
  source   = "./modules/databases/app_config"
  for_each = local.database.app_config
  name     = each.value.name

  client_config       = local.client_config
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  combined_objects    = local.dynamic_app_config_combined_objects
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  settings            = each.value
  tags                = try(each.value.tags, {})
}

output "app_config" {
  value = module.app_config
}