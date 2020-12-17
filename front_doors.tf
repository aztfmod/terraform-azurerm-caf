module "front_doors" {
  source   = "./modules/networking/front_door"
  for_each = local.networking.front_doors

  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  diagnostics         = local.combined_diagnostics
  keyvaults           = local.combined_objects_keyvaults
  global_settings     = local.global_settings
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  settings            = each.value
}