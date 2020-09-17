
module "app_services" {
  source = "./modules/webapps/appservice"

  for_each = local.webapp.app_services

  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_plan_id = lookup(each.value, "app_service_plan_key", null) == null ? null : module.app_service_plans[each.value.app_service_plan_key].id
  settings            = each.value.settings
  identity            = try(each.value.identity, {})
  connection_strings  = try(each.value.connection_strings, {})
  app_settings        = try(each.value.app_settings, null)
  slots               = try(each.value.slots, {})
  global_settings     = local.global_settings
  tags                = try(each.value.tags, null)
}

output "app_services" {
  value = module.app_services
}
