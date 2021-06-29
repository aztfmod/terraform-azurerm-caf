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
  name                = try(var.settings.random_suffix_length,null) == null ? azurecaf_name.msi.result : "${azurecaf_name.msi.result}-${random_password.random_suffix.0.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = try(merge(var.base_tags, local.tags), {})
}

resource "random_password" "random_suffix" {
  count            = try(var.settings.random_suffix_length, null) != null ? 1 : 0
  # for_each         = try(var.settings.random_suffix_length, null) == null ? [] : [1]
  length           = tonumber(var.settings.random_suffix_length)
  number           = false
  special          = false
  upper            = false
  override_special = "!@#$%&"
}
