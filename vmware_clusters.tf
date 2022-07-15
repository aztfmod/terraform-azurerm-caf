module "vmware_private_clouds" {
  depends_on = [module.dynamic_keyvault_secrets]
  source     = "./modules/compute/vmware_private_clouds"
  for_each   = local.compute.vmware_private_clouds

  global_settings          = local.global_settings
  client_config            = local.client_config
  settings                 = each.value
  location                 = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  keyvaults                = local.combined_objects_keyvaults
  dynamic_keyvault_secrets = local.security.dynamic_keyvault_secrets #module.dynamic_keyvault_secrets
}

output "vmware_private_clouds" {
  value = module.vmware_private_clouds
}

module "vmware_clusters" {
  source          = "./modules/compute/vmware_clusters"
  for_each        = local.compute.vmware_clusters
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  vmware_cloud_id = can(each.value.vmware_cloud_id) ? each.value.vmware_cloud_id : local.combined_objects_vmware_private_clouds[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vmware_private_cloud_key].id
}



output "vmware_clusters" {
  value = module.vmware_clusters
}

module "vmware_express_route_authorizations" {
  source          = "./modules/compute/vmware_express_route_authorizations"
  for_each        = local.compute.vmware_express_route_authorizations
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  vmware_cloud_id = can(each.value.vmware_cloud_id) ? each.value.vmware_cloud_id : local.combined_objects_vmware_private_clouds[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vmware_private_cloud_key].id
}

output "vmware_express_route_authorizations" {
  value = module.vmware_express_route_authorizations
}


