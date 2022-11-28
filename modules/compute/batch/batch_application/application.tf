resource "azurecaf_name" "application" {
  name          = var.settings.name
  resource_type = "azurerm_batch_application"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_batch_application" "application" {
  name                = azurecaf_name.application.result
  account_name        = var.batch_account.name
  resource_group_name = var.batch_account.resource_group_name
  allow_updates       = try(var.settings.allow_updates, null)
  default_version     = try(var.settings.default_version, null)
  display_name        = try(var.settings.display_name, null)
}
