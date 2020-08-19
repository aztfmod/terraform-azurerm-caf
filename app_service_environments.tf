
module "app_service_environments" {
  source = "/tf/caf/modules/terraform-azurerm-caf-ase"

  for_each = var.app_service_environments

  resource_group_name       = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                  = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  prefix                    = var.global_settings.prefix
  convention                = lookup(each.value, "convention", var.global_settings.convention)
  tags                      = lookup(each.value, "tags", null)
  name                      = each.value.name
  kind                      = lookup(each.value, "kind", "ASEV2")
  zone                      = lookup(each.value, "zone", null)
  subnet_id                 = local.vnets[each.value.vnet_key].subnets[each.value.subnet_key].id
  subnet_name               = local.vnets[each.value.vnet_key].subnets[each.value.subnet_key].name
  internalLoadBalancingMode = each.value.internalLoadBalancingMode
  diagnostic_profiles       = lookup(each.value, "diagnostic_profiles", null)
  diagnostics               = lookup(each.value, "diagnostic_profiles", null) == null ? null : local.diagnostics

}
