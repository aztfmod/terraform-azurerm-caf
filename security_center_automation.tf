module security_center_automation {
  source   = "./modules/security_center/security_center_automation"
  for_each = try(local.shared_services.security_center_automation, {})

  resource_group_name           = module.resource_groups[each.value.resource_group_key].name
  location                      = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics                   = local.combined_diagnostics
  client_config                 = local.client_config
  global_settings               = local.global_settings
  subscription_id               = data.azurerm_client_config.current.subscription_id
  eventhub_namespace_id         = try(module.event_hub_namespaces[each.value.eventhub_namespace_key].id, null)
  eventhub_namespace_connection = try(module.event_hub_namespaces[each.value.eventhub_namespace_key].connection_string_primary, null)
  loganalytics_workspace        = try(module.log_analytics[each.value.loganalytics_workspace_key].id, null)
  settings                      = each.value
  base_tags                     = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
