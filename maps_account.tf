module "maps_accounts" {
  source   = "./modules/maps/maps_account"
  for_each = local.maps.maps_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  settings            = each.value
  remote_objects = {
    keyvaults = local.combined_objects_keyvaults
  }
}

output "maps_accounts" {
  value = module.maps_accounts
}