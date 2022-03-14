

module "proximity_placement_groups" {
  source   = "./modules/compute/proximity_placement_group"
  for_each = local.compute.proximity_placement_groups

  global_settings     = local.global_settings
  client_config       = local.client_config
  name                = each.value.name
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}


output "proximity_placement_groups" {
  value = module.proximity_placement_groups

}
