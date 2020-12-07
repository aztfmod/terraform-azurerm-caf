module private_endpoints {
  source = "./modules/networking/private_links/endpoints"
  for_each = {
    for key, value in try(var.networking.vnets, {}) : key => value
    if try(var.networking.private_endpoints, null) != null
  }

  global_settings   = local.global_settings
  client_config     = local.client_config
  resource_groups   = module.resource_groups
  settings          = each.value
  vnet              = module.networking[each.key]
  private_endpoints = var.networking.private_endpoints
  base_tags         = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

  remote_objects = {
    diagnostic_storage_accounts = local.combined_diagnostics.storage_accounts
    event_hub_namespaces        = local.combined_objects_event_hub_namespaces
    keyvaults                   = local.combined_objects_keyvaults 
    storage_accounts            = local.combined_objects_storage_accounts
  }
  
}