module "notification_hub_namespaces" {
  source   = "./modules/messaging/notification_hub/namespace"
  for_each = local.messaging.notification_hub_namespaces

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "notification_hub_namespaces" {
  value = module.notification_hub_namespaces
}

module "notification_hubs" {
  source   = "./modules/messaging/notification_hub/hub"
  for_each = local.messaging.notification_hubs

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  base_tags           = local.global_settings.inherit_tags
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  namespace_name      = local.combined_objects_notification_hub_namespaces[try(each.value.namespace.lz_key, local.client_config.landingzone_key)][try(each.value.namespace.key, each.value.namespace_key)].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  key_vault_id        = can(each.value.key_vault_id) ? each.value.key_vault_id : try(local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key].id, null)
}

output "notification_hubs" {
  value = module.notification_hubs
}

module "notification_hub_auth_rules" {
  source   = "./modules/messaging/notification_hub/hub/auth_rules"
  for_each = local.messaging.notification_hub_auth_rules

  global_settings       = local.global_settings
  client_config         = local.client_config
  settings              = each.value
  notification_hub_name = module.notification_hubs[each.value.notification_hub_key].name
  namespace_name        = local.combined_objects_notification_hub_namespaces[try(each.value.namespace.lz_key, local.client_config.landingzone_key)][try(each.value.namespace.key, each.value.namespace_key)].name
  resource_group_name   = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
}

output "notification_hub_auth_rules" {
  value = module.notification_hub_auth_rules
}