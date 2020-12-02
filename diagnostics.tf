
module diagnostic_storage_accounts {
  source   = "./modules/storage_account"
  for_each = local.diagnostics.diagnostic_storage_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  storage_account     = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

module "diagnostic_event_hub_namespaces" {
  source   = "./modules/event_hub_namespaces"
  for_each = local.diagnostics.diagnostic_event_hub_namespaces

  global_settings   = local.global_settings
  settings          = each.value
  resource_groups   = module.resource_groups
  client_config     = local.client_config
  base_tags         = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

module "diagnostic_log_analytics" {
  source   = "./modules/log_analytics"
  for_each = local.diagnostics.diagnostic_log_analytics

  global_settings = local.global_settings
  log_analytics   = each.value
  resource_groups = module.resource_groups
  base_tags       = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}
