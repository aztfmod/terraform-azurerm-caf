resource "azurecaf_name" "ntf" {
  name          = var.settings.name
  resource_type = "azurerm_notification_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_notification_hub" "ntf" {
  name                     = azurecaf_name.ntf.result
  location                 = var.location
  resource_group_name      = var.resource_group_name
  namespace_name           =  var.namespace_name
  tags                     = local.tags
  // add apns_credential block and gcm_credential block
}
