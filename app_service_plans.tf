
module "app_service_plans" {
  source = "./modules/webapps/asp"

  for_each = local.webapp.app_service_plans

  resource_group_name        = module.resource_groups[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_environment_id = lookup(each.value, "app_service_environment_key", null) == null ? null : module.app_service_environments[each.value.app_service_environment_key].id
  tags                       = try(each.value.tags, null)
  kind                       = try(each.value.kind, null)
  settings                   = each.value
  global_settings            = local.global_settings
}

output app_service_plans {
  value       = module.app_service_plans
  sensitive   = true
}
