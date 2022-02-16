module "container_groups" {
  source     = "./modules/compute/container_group"
  for_each   = local.compute.container_groups
  depends_on = [module.dynamic_keyvault_secrets]

  base_tags                = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  client_config            = local.client_config
  combined_diagnostics     = local.combined_diagnostics
  diagnostic_profiles      = try(each.value.diagnostic_profiles, {})
  global_settings          = local.global_settings
  location                 = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name      = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  settings                 = each.value
  dynamic_keyvault_secrets = try(local.security.dynamic_keyvault_secrets, {})

  combined_resources = {
    keyvaults          = local.combined_objects_keyvaults
    managed_identities = local.combined_objects_managed_identities
    network_profiles   = local.combined_objects_network_profiles
  }
}

module "network_profiles" {
  source   = "./modules/networking/network_profile"
  for_each = local.networking.network_profiles


  base_tags       = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value

  resource_group = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key], null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key], null)
  )

  remote_objects = {
    networking      = local.combined_objects_networking
    virtual_subnets = local.combined_objects_virtual_subnets
  }
}

output "container_groups" {
  value = module.container_groups
}

