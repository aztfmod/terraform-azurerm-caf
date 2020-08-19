resource "azurecaf_naming_convention" "plans" {
  for_each      = var.app_service_plans

  name          = each.value.name
  prefix        = var.prefix
  resource_type = "azurerm_app_service_plan"
  convention    = var.convention
}

resource "azurerm_app_service_plan" "asps" {
  for_each            = var.app_service_plans

  name                = azurecaf_naming_convention.plans[each.key].result
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  kind                = each.value.kind
  reserved            = lookup(each.value, "reserved", false)

  #for high density support 
  per_site_scaling = lookup(each.value.sku, "per_site_scaling", false)

  sku {
    tier = each.value.sku.tier
    size = each.value.sku.size
    capacity = each.value.sku.capacity
  }

  app_service_environment_id  = var.ase_id
  tags                        = local.tags

  timeouts {
    create = "3h"
    update = "3h"
  }
}


