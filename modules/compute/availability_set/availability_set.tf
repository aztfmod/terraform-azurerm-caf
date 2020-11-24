resource "azurecaf_name" "avset" {

  name          = var.name
  resource_type = "azurerm_availability_set"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}



resource "azurerm_availability_set" "avset" {
  name                = azurecaf_name.avset.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags