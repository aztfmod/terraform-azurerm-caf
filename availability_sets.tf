module "availability_sets" {
  source   = "./modules/compute/availability_set"
  for_each = local.compute.availability_sets

  global_settings            = local.global_settings
  client_config              = local.client_config
  settings                   = each.value
  name                       = each.value.name
  resource_group_name        = local.resource_groups[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags                  = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  availability_sets          = local.compute.availability_sets
  proximity_placement_groups = local.combined_objects_proximity_placement_groups
  ppg_id                     = try(module.proximity_placement_groups[each.value.proximity_placement_group_key].id, null)

}



output "availability_sets" {
  value = module.availability_sets

}