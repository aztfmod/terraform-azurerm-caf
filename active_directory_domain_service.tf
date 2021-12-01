module "active_directory_domain_service" {
  source   = "./modules/identity/active_directory_domain_service"
  for_each = local.identity.active_directory_domain_service

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )


  remote_objects = {
    vnets          = try(local.combined_objects_networking, null)
    resource_group = local.combined_objects_resource_groups
    location       = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  }
}
output "active_directory_domain_service" {
  value = module.active_directory_domain_service
}


module "active_directory_domain_service_replica_set" {
  source   = "./modules/identity/active_directory_domain_service_replica_set"
  for_each = local.identity.active_directory_domain_service_replica_set

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  subnet_id = coalesce(
    try(local.combined_objects_networking[each.value.subnet.lz_key][each.value.subnet.vnet_key][each.value.subnet.key].id, null),
    try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.subnet.vnet_key][each.value.subnet.key].id, null),
    try(each.value.subnet.id, null)
  )

  remote_objects = {
    location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  }
}
output "active_directory_domain_service_replica_set" {
  value = module.active_directory_domain_service_replica_set
}