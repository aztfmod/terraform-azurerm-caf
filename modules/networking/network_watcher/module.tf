
resource "azurecaf_name" "netwatcher" {
  name          = var.settings.name
  resource_type = "azurerm_network_watcher"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_network_watcher" "netwatcher" {
  name                = azurecaf_name.netwatcher.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}
