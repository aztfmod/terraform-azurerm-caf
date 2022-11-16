resource "azurecaf_name" "wvdws" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_desktop_workspace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_desktop_workspace" "wvdws" {
  name                = azurecaf_name.wvdws.result
  location            = var.location
  resource_group_name = var.resource_group_name

  friendly_name = try(var.settings.friendly_name, null)
  description   = try(var.settings.description, null)
  tags          = local.tags
}

