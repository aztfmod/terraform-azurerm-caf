module "authorization_rules" {
  source   = "./auth_rules"
  for_each = try(var.settings.auth_rules, {})

  resource_group_name   = local.resource_group_name
  client_config         = var.client_config
  global_settings       = var.global_settings
  settings              = each.value
  namespace_name        = var.namespace_name
  notification_hub_name = azurerm_notification_hub.hub.name
}