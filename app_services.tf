
module "app_service_environments" {
  source = "./modules/terraform-azurerm-caf-ase"

  for_each = local.webapp.app_service_environments

  resource_group_name       = module.resource_groups[each.value.resource_group_key].name
  location                  = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  tags                      = try(each.value.tags, null)
  name                      = each.value.name
  kind                      = try(each.value.kind, "ASEV2")
  zone                      = try(each.value.zone, null)
  subnet_id                 = module.networking[each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_name               = module.networking[each.value.vnet_key].subnets[each.value.subnet_key].name
  internalLoadBalancingMode = each.value.internalLoadBalancingMode
  front_end_size            = try(each.value.front_end_size, "Standard_D1_V2")
  diagnostic_profiles       = try(each.value.diagnostic_profiles, null)
  diagnostics               = local.diagnostics
  global_settings           = local.global_settings

}

module "app_service_plans" {
  source = "./modules/terraform-azurerm-caf-asp"

  for_each = local.webapp.app_service_plans

  resource_group_name        = module.resource_groups[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_environment_id = lookup(each.value, "app_service_environment_key", null) == null ? null : module.app_service_environments[each.value.app_service_environment_key].id
  tags                       = try(each.value.tags, null)
  kind                       = try(each.value.kind, null)
  settings                   = each.value
  global_settings            = local.global_settings
}



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
