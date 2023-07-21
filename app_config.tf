module "app_config" {
  source   = "./modules/databases/app_config"
  for_each = local.database.app_config
  name     = each.value.name

  client_config       = local.client_config
  combined_objects    = local.dynamic_app_config_combined_objects
  global_settings     = local.global_settings
  settings            = each.value
  vnets               = local.combined_objects_networking
  private_dns         = local.combined_objects_private_dns
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "app_config" {
  value = module.app_config
}