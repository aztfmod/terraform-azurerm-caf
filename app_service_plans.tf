module "app_service_plans" {
  source = "/tf/caf/modules/terraform-azurerm-caf-asp"

  for_each = var.app_service_plans

  prefix                     = local.global_settings.prefix
  resource_group_name        = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  convention                 = lookup(each.value, "convention", local.global_settings.convention)
  max_length                 = lookup(each.value, "max_length", local.global_settings.max_length)
  tags                       = lookup(each.value, "tags", null)
  app_service_environment_id = lookup(each.value, "app_service_environment_key", null) == null ? null : module.app_service_environments[each.value.app_service_environment_key].id
  settings                   = each.value
  kind                       = lookup(each.value, "kind", null)
}
