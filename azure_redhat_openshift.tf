module "aro" {
  source     = "./modules/compute/azure_redhat_openshift"
  for_each   = local.compute.aro_clusters
  depends_on = [time_sleep.azurerm_role_assignment_for]

  location                 = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  resource_group           = can(each.value.resource_group.id) || can(each.value.resource_group_id) ? try(each.value.resource_group.id, each.value.resource_group_id) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].id
  base_tags                = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  client_config            = local.client_config
  combined_diagnostics     = local.combined_diagnostics
  diagnostic_profiles      = try(each.value.diagnostic_profiles, {})
  global_settings          = local.global_settings
  settings                 = each.value
  dynamic_keyvault_secrets = try(local.security.dynamic_keyvault_secrets, {})

  combined_resources = {
    resource_groups      = local.combined_objects_resource_groups
    keyvaults            = local.combined_objects_keyvaults
    managed_identities   = local.combined_objects_managed_identities
    vnets                = local.combined_objects_networking
    virtual_subnets      = local.combined_objects_virtual_subnets
    service_principals   = local.combined_objects_azuread_service_principals
    disk_encryption_sets = local.combined_objects_disk_encryption_sets
  }
}

output "aro" {
  value = module.aro
}

