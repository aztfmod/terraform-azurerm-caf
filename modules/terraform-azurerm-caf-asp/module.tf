resource "azurecaf_naming_convention" "plan" {
  name          = var.settings.name
  prefix        = var.prefix
  resource_type = "azurerm_app_service_plan"
  convention    = var.convention
  max_length    = var.max_length
}

resource "azurerm_app_service_plan" "asp" {
  name                         = azurecaf_naming_convention.plan.result
  location                     = var.location
  resource_group_name          = var.resource_group_name
  kind                         = var.kind
  maximum_elastic_worker_count = lookup(var.settings, "maximum_elastic_worker_count", null)

  # For kind=Linux must be set to true and for kind=Windows must be set to false
  reserved = lookup(var.settings, "reserved", null) == null ? null : var.settings.reserved

  #for high density support 
  per_site_scaling = lookup(var.settings.sku, "per_site_scaling", false)

  sku {
    tier     = var.settings.sku.tier
    size     = var.settings.sku.size
    capacity = lookup(var.settings.sku, "capacity", null)
  }

  app_service_environment_id = var.app_service_environment_id
  tags                       = local.tags

  timeouts {
    create = "3h"
    update = "3h"
  }
}


