module "eventgrid_domain" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain"
  for_each = local.messaging.eventgrid_domain

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
    vnets          = local.combined_objects_networking
    private_dns    = local.combined_objects_private_dns
  }
}
output "eventgrid_domain" {
  value = module.eventgrid_domain
}

module "eventgrid_topic" {
  source   = "./modules/messaging/eventgrid/eventgrid_topic"
  for_each = local.messaging.eventgrid_topic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = {
    resource_group = local.combined_objects_resource_groups
  }
}
output "eventgrid_topic" {
  value = module.eventgrid_topic
}

module "eventgrid_event_subscription" {
  source   = "./modules/messaging/eventgrid/eventgrid_event_subscription"
  for_each = local.messaging.eventgrid_event_subscription

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    all                    = local.remote_objects,
    functions              = local.combined_objects_function_apps,
    eventhubs              = local.combined_objects_event_hubs,
    servicebus_topic       = local.combined_objects_servicebus_topics,
    servicebus_queues      = local.combined_objects_servicebus_queues,
    storage_accounts       = local.combined_objects_storage_accounts,
    hybrid_connections     = local.combined_objects_relay_hybrid_connection,
    storage_account_queues = local.combined_objects_storage_account_queues
  }
}
output "eventgrid_event_subscription" {
  value = module.eventgrid_event_subscription
}

module "eventgrid_domain_topic" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain_topic"
  for_each = local.messaging.eventgrid_domain_topic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    resource_group   = local.combined_objects_resource_groups
    eventgrid_domain = local.combined_objects_eventgrid_domains
  }
}
output "eventgrid_domain_topic" {
  value = module.eventgrid_domain_topic
}

module "eventgrid_system_topic" {
  source   = "./modules/messaging/eventgrid/eventgrid_system_topic"
  for_each = local.messaging.eventgrid_system_topic

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}

  location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = local.remote_objects
}
output "eventgrid_system_topic" {
  value = module.eventgrid_system_topic
}
module "eventgrid_system_event_subscription" {
  source   = "./modules/messaging/eventgrid/eventgrid_system_event_subscription"
  for_each = local.messaging.eventgrid_system_event_subscription

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = merge(
    local.remote_objects,
    {
      functions               = local.combined_objects_function_apps,
      eventhubs               = local.combined_objects_event_hubs,
      eventgrid_system_topics = local.combined_objects_eventgrid_system_topics,
      hybrid_connections      = local.combined_objects_relay_hybrid_connection,
      storage_account_queues  = local.combined_objects_storage_account_queues
    }
  )
}
output "eventgrid_system_event_subscription" {
  value = module.eventgrid_system_event_subscription
}
