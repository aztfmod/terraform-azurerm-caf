module "container_groups" {
  source   = "./modules/compute/container_group"
  for_each = local.compute.container_groups

  base_tags            = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  client_config        = local.client_config
  combined_diagnostics = local.combined_diagnostics
  # combined_managed_identities  = local.combined_objects_managed_identities
  # combined_vnets               = local.combined_objects_networking
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  settings            = each.value
  network_profile_id  = try(module.network_profiles[each.value.network_profile_key].id,null)

  combined_resources = {
    keyvaults          = local.combined_objects_keyvaults
    managed_identities = local.combined_objects_managed_identities
    vnets              = local.combined_objects_networking
    resource_groups    = local.combined_objects_resource_groups
  }
}

output "container_groups" {
  value = module.container_groups
}

