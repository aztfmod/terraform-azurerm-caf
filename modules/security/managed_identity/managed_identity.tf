resource "azurecaf_name" "msi" {
  name          = var.name
  resource_type = "azurerm_user_assigned_identity"
  prefixes      = try(var.settings.naming_convention.prefixes, var.global_settings.prefixes)
  random_length = try(var.settings.naming_convention.random_length, var.global_settings.random_length)
  clean_input   = true
  passthrough   = try(var.settings.naming_convention.passthrough, var.global_settings.passthrough)
  use_slug      = try(var.settings.naming_convention.use_slug, var.global_settings.use_slug)
}

resource "azurerm_user_assigned_identity" "msi" {
  name                = azurecaf_name.msi.result
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = local.tags

}

resource "time_sleep" "propagate_to_azuread" {
  depends_on = [azurerm_user_assigned_identity.msi]

  create_duration = "30s"
}