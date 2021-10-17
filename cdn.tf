output "cdn_profiles" {
  value = module.cdn_profiles
}

module "cdn_profiles" {
  source              = "./modules/networking/cdn"
  depends_on          = [module.storage_accounts]
  for_each            = local.networking.cdn_profiles
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  storage_accounts    = local.combined_objects_storage_accounts
  client_config       = local.client_config
  location            = try(each.value.location, "Global")
}
