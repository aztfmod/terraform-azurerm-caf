
resource "azurecaf_name" "image_name" {
  name          = var.settings.name
  prefixes      = var.global_settings.prefixes
  resource_type = "azurerm_shared_image"
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_shared_image" "image" {
  name                = azurecaf_name.image_name.result
  gallery_name        = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.settings.os_type
  identifier {
    publisher = var.settings.publisher
    offer     = var.settings.offer
    sku       = var.settings.sku
  }

}
