module "event_hub_namespace_auth_rules" {
  source   = "./auth_rules"
  for_each = try(var.settings.auth_rules, {})

  resource_group  = var.resource_group
  client_config   = var.client_config
  global_settings = var.global_settings
  settings        = each.value
  namespace_name  = azurerm_eventhub_namespace.evh.name
}