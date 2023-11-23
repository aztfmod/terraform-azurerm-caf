module "wvd_scaling_plans" {
  source          = "./modules/compute/wvd_scaling_plan"
  for_each        = local.compute.wvd_scaling_plans
  client_config   = local.client_config
  global_settings = local.global_settings
  settings        = each.value
  base_tags       = local.global_settings.inherit_tags
  resource_group  = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  remote_objects = {
    wvd_host_pools = local.combined_objects_wvd_host_pools
  }
}

output "wvd_scaling_plans" {
  value     = module.wvd_scaling_plans
}