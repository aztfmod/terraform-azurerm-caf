module "notification_hub_namespaces" {
  source      = "./modules/messaging/notification_hub_namespaces"
  for_each = try(local.messaging.notification_hub_namespaces, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "notification_hub_namespaces" {
  value = module.notification_hub_namespaces
}


module "notification_hubs" {
  source      = "./modules/messaging/notification_hubs"
  for_each = try(local.messaging.notification_hubs, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  namespace_name      = module.notification_hub_namespaces[each.value.notification_hub_namespace_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}

  depends_on = [
  module.notification_hub_namespaces  
  ]
}

output "notification_hubs" {
  value = module.notification_hubs
}


module "notification_hub_authorization_rules" {
  source   = "./modules/messaging/notification_hub_authorization_rules"
  for_each = try(local.messaging.notification_hub_authorization_rules, {})

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings            = each.value
  namespace_name      = module.notification_hub_namespaces[each.value.notification_hub_namespace_key].name
  notification_hub_name = module.notification_hubs[each.value.notification_hub_key].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  
  depends_on = [
    module.notification_hub_namespaces,
    module.notification_hubs
  ]
}

module "notification_hub_namespaces_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = local.messaging.notification_hub_namespaces

  resource_id       = module.notification_hub_namespaces[each.key].id
  resource_location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}


