locals {
  tags = try(var.settings.tags, null) == null ? null : try(var.settings.tags.environment, null) == null ? var.settings.tags : merge(lookup(var.settings, "tags", {}), { "environment" : var.global_settings.environment })
}
resource "azurecaf_name" "msi" {
  name          = var.name
  resource_type = "azurerm_user_assigned_identity"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_user_assigned_identity" "msi" {
  name                = azurecaf_name.msi.result
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = try(merge(var.base_tags, local.tags), {})
}

