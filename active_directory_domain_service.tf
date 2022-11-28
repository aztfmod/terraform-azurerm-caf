module "active_directory_domain_service" {
  source   = "./modules/identity/active_directory_domain_service"
  for_each = local.identity.active_directory_domain_service

  # to destroy azuread_group at last
  depends_on = [module.azuread_groups, module.azuread_service_principals]

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    vnets          = try(local.combined_objects_networking, null)
    resource_group = local.combined_objects_resource_groups
    location       = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  }
}
output "active_directory_domain_service" {
  value = module.active_directory_domain_service
}


module "active_directory_domain_service_replica_set" {
  source   = "./modules/identity/active_directory_domain_service_replica_set"
  for_each = local.identity.active_directory_domain_service_replica_set

  depends_on = [azurerm_virtual_network_peering.peering]

  settings      = each.value
  client_config = local.client_config
  location      = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location


  remote_objects = {
    vnets                           = try(local.combined_objects_networking, null)
    active_directory_domain_service = try(module.active_directory_domain_service, null)
  }

}
output "active_directory_domain_service_replica_set" {
  value = module.active_directory_domain_service_replica_set
}