
locals {
  # Need to update the tags if the environment tag is updated with the rover command line
  caf_tags = can(var.settings.tags.caf_environment) || can(var.settings.tags.environment) ? merge(lookup(var.settings, "tags", {}), { "caf_environment" : var.global_settings.environment }) : {}
}

# naming convention azure_caf
resource "azurecaf_name" "namespace" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_namespace" "namespace" {
  name                         = azurecaf_name.namespace.result
  sku                          = var.settings.sku
  capacity                     = try(var.settings.capacity, null)
  zone_redundant               = try(var.settings.zone_redundant, null)
  tags                         = merge(try(var.settings.tags, null), local.caf_tags)
  premium_messaging_partitions = try(var.settings.premium_messaging_partitions, null)
  location                     = local.location
  resource_group_name          = local.resource_group_name
}
