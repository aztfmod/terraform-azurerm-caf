
resource "azurecaf_name" "plan" {
  name          = var.settings.name
  resource_type = "azurerm_app_service_plan"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}


resource "azurerm_app_service_plan" "asp" {
  name                         = azurecaf_name.plan.result
  location                     = var.location
  resource_group_name          = var.resource_group_name
  kind                         = try(var.kind, null)
  maximum_elastic_worker_count = lookup(var.settings, "maximum_elastic_worker_count", null)

  # For kind=Linux must be set to true and for kind=Windows must be set to false
  reserved         = lookup(var.settings, "reserved", null) == null ? null : var.settings.reserved
  per_site_scaling = lookup(var.settings.sku, "per_site_scaling", false)
  is_xenon         = lookup(var.settings, "is_xenon", null)

  sku {
    tier     = var.settings.sku.tier
    size     = var.settings.sku.size
    capacity = lookup(var.settings.sku, "capacity", null)
  }

  app_service_environment_id = var.app_service_environment_id
  tags                       = local.tags

  timeouts {
    create = "5h"
    update = "5h"
  }

  lifecycle {
    # TEMP until native tf provider for ASE ready to avoid force replacement of asp on every ase changes
    ignore_changes = [app_service_environment_id]
  }
}


