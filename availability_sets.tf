module "availability_sets" {
  source   = "./modules/compute/availability_set"
  for_each = local.compute.availability_sets

  global_settings            = local.global_settings
  client_config              = local.client_config
  settings                   = each.value
  name                       = each.value.name
  location                   = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name        = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                  = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  availability_sets          = local.compute.availability_sets
  proximity_placement_groups = local.combined_objects_proximity_placement_groups
  ppg_id                     = try(module.proximity_placement_groups[each.value.proximity_placement_group_key].id, null)

}



output "availability_sets" {
  value = module.availability_sets

}