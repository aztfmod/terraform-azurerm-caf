module "front_doors" {
  source   = "./modules/networking/front_door"
  for_each = local.networking.front_doors

  base_tags               = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  client_config           = local.client_config
  diagnostics             = local.combined_diagnostics
  front_door_waf_policies = local.combined_objects_front_door_waf_policies
  global_settings         = local.global_settings
  resource_group_name     = module.resource_groups[each.value.resource_group_key].name
  settings                = each.value
}