resource "azurecaf_name" "rule" {
  name          = var.settings.name
  resource_type = "azurerm_notification_hub_authorization_rule"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_notification_hub_authorization_rule" "rule" {
  name                  = azurecaf_name.rule.result
  notification_hub_name = var.notification_hub_name
  namespace_name        = var.namespace_name
  resource_group_name   = var.resource_group_name

  manage = try(var.settings.manage, null)
  send   = try(var.settings.send, null)
  listen = try(var.settings.listen, null)
}
