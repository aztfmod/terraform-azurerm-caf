locals {
  servicebus         = try(var.service_bus.servicebus, {})
  resource_group_key = try(var.service_bus.resource_group_key, {})
}

module "servicebus_namespace" {
  source   = "./modules/service_bus/namespace"
  for_each = local.servicebus

  resource_group_name = module.resource_groups[local.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[local.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[local.resource_group_key].tags : {}
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  settings            = each.value
}

module "servicebus_topic" {
  source   = "./modules/service_bus/topic"
  for_each = local.servicebus

  resource_group_name = module.resource_groups[local.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[local.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  settings            = each.value
  depends_on = [
    module.servicebus_namespace
  ]
}

module "servicebus_queue" {
  source   = "./modules/service_bus/queue"
  for_each = local.servicebus

  resource_group_name = module.resource_groups[local.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[local.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  settings            = each.value
  depends_on = [
    module.servicebus_namespace
  ]
}