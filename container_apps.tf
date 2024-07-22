module "container_apps" {
  source   = "./modules/compute/container_app"
  for_each = local.compute.container_apps

  location                     = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group               = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name          = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                    = local.global_settings.inherit_tags
  container_app_environment_id = can(each.value.container_app_environment_id) ? each.value.container_app_environment_id : local.combined_objects_container_app_environments[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.container_app_environment_key].id
  client_config                = local.client_config
  combined_diagnostics         = local.combined_diagnostics
  diagnostic_profiles          = try(each.value.diagnostic_profiles, {})
  diagnostics                  = local.combined_diagnostics
  combined_resources = {
    keyvaults                              = local.combined_objects_keyvaults
    managed_identities                     = local.combined_objects_managed_identities
    container_app_environment_certificates = local.combined_objects_container_app_environment_certificates
    container_app_environment_storages     = local.combined_objects_container_app_environment_storages
  }
  global_settings = local.global_settings
  settings        = each.value
}

output "container_apps" {
  value = module.container_apps
}

