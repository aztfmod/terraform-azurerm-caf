
module "app_service_plans" {
  source = "./modules/webapps/asp"

  for_each = local.webapp.app_service_plans

  resource_group_name        = local.resource_groups[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags                  = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  app_service_environment_id = try(each.value.app_service_environment_key, null) == null ? null : try(local.combined_objects_app_service_environments[local.client_config.landingzone_key][each.value.app_service_environment_key].id, local.combined_objects_app_service_environments[each.value.lz_key][each.value.app_service_environment_key].id)
  tags                       = try(each.value.tags, null)
  kind                       = try(each.value.kind, null)
  settings                   = each.value
  global_settings            = local.global_settings
}

output "app_service_plans" {
  value = module.app_service_plans

}
