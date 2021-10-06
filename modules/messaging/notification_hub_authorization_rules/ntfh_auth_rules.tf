resource "azurecaf_name" "ntf_auth_rules" {
  name          = var.settings.name
  resource_type = "azurerm_notification_hub_authorization_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_notification_hub_authorization_rule" "ntf_auth_rules" {
  name                     = azurecaf_name.ntf_auth_rules.result
  // location                 = var.location
  resource_group_name      = var.resource_group_name
  namespace_name           =  var.namespace_name
  notification_hub_name    =  var.notification_hub_name
  listen                   = try(var.settings.listen, false)
  send                     = try(var.settings.send, false)
  manage                   = try(var.settings.manage, false)
  // tags                     = merge(try(var.settings.tags, {}), local.tags)
  // add apns_credential block and gcm_credential block
}
