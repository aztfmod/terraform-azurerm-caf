locals {
  # Diagnostics services to create
  diagnostics = {
    diagnostic_event_hub_namespaces = try(var.diagnostics.diagnostic_event_hub_namespaces, {})
    diagnostic_log_analytics        = try(var.diagnostics.diagnostic_log_analytics, {})
    diagnostic_storage_accounts     = try(var.diagnostics.diagnostic_storage_accounts, {})
  }

  # Remote amd locally created diagnostics  objects
  combined_diagnostics = {
    diagnostics_definition   = try(var.diagnostics.diagnostics_definition, {})
    diagnostics_destinations = try(var.diagnostics.diagnostics_destinations, {})
    storage_accounts         = merge(try(var.diagnostics.storage_accounts, {}), module.diagnostic_storage_accounts)
    log_analytics            = merge(try(var.diagnostics.log_analytics, {}), module.diagnostic_log_analytics)
    event_hub_namespaces     = merge(try(var.diagnostics.event_hub_namespaces, {}), module.diagnostic_event_hub_namespaces)
  }
}

# Output diagnostics
output "diagnostics" {
  value = local.combined_diagnostics

}

module "diagnostic_storage_accounts" {
  source   = "./modules/storage_account"
  for_each = local.diagnostics.diagnostic_storage_accounts

  global_settings     = local.global_settings
  client_config       = local.client_config
  storage_account     = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

resource "azurerm_storage_account_customer_managed_key" "diasacmk" {
  depends_on = [module.keyvault_access_policies]
  for_each = {
    for key, value in local.diagnostics.diagnostic_storage_accounts : key => value
    if try(value.customer_managed_key, null) != null
  }

  storage_account_id = module.diagnostic_storage_accounts[each.key].id
  key_vault_id       = module.keyvaults[each.value.customer_managed_key.keyvault_key].id
  key_name           = module.keyvault_keys[each.value.customer_managed_key.keyvault_key_key].name
}

module "diagnostic_event_hub_namespaces" {
  source   = "./modules/event_hubs/namespaces"
  for_each = local.diagnostics.diagnostic_event_hub_namespaces

  global_settings = local.global_settings
  settings        = each.value
  client_config   = local.client_config
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  resource_group  = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
}

module "diagnostic_event_hub_namespaces_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = local.diagnostics.diagnostic_event_hub_namespaces

  resource_id       = module.diagnostic_event_hub_namespaces[each.key].id
  resource_location = module.diagnostic_event_hub_namespaces[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}

module "diagnostic_log_analytics" {
  source   = "./modules/log_analytics"
  for_each = local.diagnostics.diagnostic_log_analytics

  global_settings     = local.global_settings
  log_analytics       = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

}

module "diagnostic_log_analytics_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = local.diagnostics.diagnostic_log_analytics

  resource_id       = module.diagnostic_log_analytics[each.key].id
  resource_location = module.diagnostic_log_analytics[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}
