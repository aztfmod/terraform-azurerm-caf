resource "azurecaf_name" "vwera" {
  name          = var.settings.name
  resource_type = "azurerm_vmware_express_route_authorization"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_vmware_express_route_authorization" "vwera" {
  name             = azurecaf_name.vwera.result
  private_cloud_id = var.vmware_cloud_id
}
