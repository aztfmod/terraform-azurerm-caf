module "container_app_environment" {
  source   = "./modules/compute/container_app_environment"
  for_each = local.compute.container_app_environment

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_groups = local.combined_objects_resource_groups
  diagnostics     = local.combined_diagnostics
  vnets           = local.combined_objects_networking
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  private_dns     = local.combined_objects_private_dns
}

output "container_app_environments" {
  value = module.container_app_environment
}
