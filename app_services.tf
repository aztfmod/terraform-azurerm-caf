
module "app_service_environments" {
  source = "./modules/terraform-azurerm-caf-ase"

  for_each = var.app_service_environments

  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                  = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  prefix                    = var.global_settings.prefix
  convention                = try(each.value.convention, var.global_settings.convention)
  tags                      = try(each.value.tags, null)
  name                      = each.value.name
  kind                      = try(each.value.kind, "ASEV2")
  zone                      = try(each.value.zone, null)
  subnet_id                 = local.vnets[each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_name               = local.vnets[each.value.vnet_key].subnets[each.value.subnet_key].name
  internalLoadBalancingMode = each.value.internalLoadBalancingMode
  front_end_size            = try(each.value.front_end_size, "Standard_D1_V2")
  diagnostic_profiles       = try(each.value.diagnostic_profiles, null)
  diagnostics               = local.diagnostics

}

module "app_service_plans" {
  source = "./modules/terraform-azurerm-caf-asp"

  for_each = var.app_service_plans

  prefix                     = local.global_settings.prefix
  resource_group_name        = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                   = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  app_service_environment_id = lookup(each.value, "app_service_environment_key", null) == null ? null : module.app_service_environments[each.value.app_service_environment_key].id
  convention                 = try(each.value.convention, local.global_settings.convention)
  max_length                 = try(each.value.max_length, local.global_settings.max_length)
  tags                       = try(each.value.tags, null)
  kind                       = try(each.value.kind, null)
  settings                   = each.value
}
