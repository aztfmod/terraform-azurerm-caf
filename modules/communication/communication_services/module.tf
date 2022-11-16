resource "azurecaf_name" "acs" {
  name          = var.settings.name
  resource_type = "azurerm_communication_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_communication_service" "acs" {
  name                = azurecaf_name.acs.result
  resource_group_name = var.resource_group_name
  data_location       = try(var.settings.data_location, null)
  tags                = local.tags
}

