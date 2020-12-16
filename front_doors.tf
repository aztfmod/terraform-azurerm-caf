module "front_doors" {
  source   = "./modules/networking/front_door"
  for_each = local.networking.front_doors

  diagnostics         = local.combined_diagnostics
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  global_settings     = local.global_settings
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  settings            = each.value
  
}