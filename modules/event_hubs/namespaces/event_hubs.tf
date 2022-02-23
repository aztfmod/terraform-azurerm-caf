module "event_hubs" {
  source   = "../hubs"
  for_each = try(var.settings.event_hubs, {})

  resource_group     = var.resource_group
  client_config      = var.client_config
  global_settings    = var.global_settings
  settings           = each.value
  namespace_name     = azurerm_eventhub_namespace.evh.name
  storage_account_id = try(var.storage_accounts[try(each.value.storage_account.lz_key, var.client_config.landingzone_key)][each.value.storage_account.key].id, null)
  base_tags          = merge(var.base_tags, try(each.value.tags, {}))
}