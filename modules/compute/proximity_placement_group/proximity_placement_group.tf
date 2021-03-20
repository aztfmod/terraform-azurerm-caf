# Name of the PPG
resource "azurecaf_name" "ppg" {

  name          = var.name
  resource_type = "azurerm_proximity_placement_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# proximity placement group
resource "azurerm_proximity_placement_group" "ppg" {

  name                = azurecaf_name.ppg.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}
