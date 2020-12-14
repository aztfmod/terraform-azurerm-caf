module "front_doors" {
  source   = "./modules/networking/front_door"
  for_each = local.networking.front_doors

  global_settings     = local.global_settings
  settings            = each.value
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  tags                = try(local.global_settings.inherit_tags, false) ? merge(module.resource_groups[each.value.resource_group_key].tags, try(each.value.tags, null)) : try(each.value.tags, null)
}