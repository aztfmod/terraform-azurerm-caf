module event_hub {
  source     = "./modules/event_hub_namespaces/event_hub"
  depends_on = [module.event_hub_namespaces]
  for_each   = try(var.event_hub, {})

  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = var.diagnostics.event_hub_namespaces[var.diagnostics.diagnostics_destinations.event_hub_namespaces[each.value.destination_key].event_hub_namespace_key].name
  storage_account_id  = try(module.storage_accounts[each.value.storage_account_key].id, null)
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}