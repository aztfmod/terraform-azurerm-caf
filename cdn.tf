output "cdn_profile" {
  value = module.cdn_profile
}

module "cdn_profile" {
  source          = "./modules/networking/cdn"
  depends_on      = [module.storage_accounts]
  for_each        = local.networking.cdn_profiles
  diagnostics     = local.combined_diagnostics
  global_settings = local.global_settings
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  settings        = each.value
  endpoints       = local.networking.cdn_endpoints
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name, null),
    try(each.value.resource_group.name, null)
  )
  storage_accounts = local.combined_objects_storage_accounts
  client_config    = local.client_config
  location         = try(each.value.location, "Global")
}
