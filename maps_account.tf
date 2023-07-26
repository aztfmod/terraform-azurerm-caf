module "maps_account" {
  source   = "./modules/maps/maps_account"
  for_each = try(local.maps.maps_account, {})

  global_settings     = local.global_settings
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  sku_name            = each.value.sku_name
  settings            = each.value
}

output "maps_account" {
  value     = module.maps_account
}