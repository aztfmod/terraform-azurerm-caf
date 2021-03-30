resource "azurecaf_name" "sig_name" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_shared_image_gallery"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}



# creates Shared Image Gallery
resource "azurerm_shared_image_gallery" "gallery" {
  name                = azurecaf_name.sig_name.result
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = var.settings.description
}

