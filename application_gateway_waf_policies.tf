module "application_gateway_waf_policies" {
  source   = "./modules/networking/application_gateway_waf_policies"
  for_each = local.networking.application_gateway_waf_policies

  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "application_gateway_waf_policies" {
  value = module.application_gateway_waf_policies
}