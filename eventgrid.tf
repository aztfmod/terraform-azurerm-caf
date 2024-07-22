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
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  settings        = each.value

  remote_objects = {
    aks_clusters               = local.combined_objects_aks_clusters
    api_management             = local.combined_objects_api_management
    app_services               = local.combined_objects_app_services
    azure_container_registries = local.combined_objects_azure_container_registries
    communication_services     = module.communication_services
    event_hubs                 = local.combined_objects_event_hubs
    eventgrid_domains          = local.combined_objects_eventgrid_domains
    eventgrid_topics           = local.combined_objects_eventgrid_topics
    eventhubs                  = local.combined_objects_event_hubs
    functions                  = local.combined_objects_function_apps
    iot_hub                    = local.combined_objects_iot_hub
    keyvaults                  = local.combined_objects_keyvaults
    machine_learning           = local.combined_objects_machine_learning
    managed_identities         = local.combined_objects_managed_identities
    maps_accounts              = module.maps_accounts
    redis_caches               = local.combined_objects_redis_caches
    resource_groups            = local.combined_objects_resource_groups
    servicebus_namespaces      = local.combined_objects_servicebus_namespaces
    servicebus_queues          = local.combined_objects_servicebus_queues
    servicebus_topic           = local.combined_objects_servicebus_topics
    signalr_services           = local.combined_objects_signalr_services
    storage_accounts           = local.combined_objects_storage_accounts
    subscriptions              = local.combined_objects_subscriptions
  }
}
output "eventgrid_system_topic" {
  value = module.eventgrid_system_topic
}

module "azurerm_eventgrid_system_topic_event_subscription" {
  source   = "./modules/messaging/eventgrid/eventgrid_system_topic_event_subscription"
  for_each = local.messaging.eventgrid_system_topic_event_subscription

  global_settings = local.global_settings
  client_config   = local.client_config
  base_tags       = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  settings        = each.value


  remote_objects = {
    eventgrid_system_topics = local.combined_objects_eventgrid_system_topics
    functions               = local.combined_objects_function_apps,
    eventhubs               = local.combined_objects_event_hubs,
    servicebus_topic        = local.combined_objects_servicebus_topics,
    servicebus_queues       = local.combined_objects_servicebus_queues,
    storage_accounts        = local.combined_objects_storage_accounts,
    hybrid_connections      = local.combined_objects_relay_hybrid_connection,
    storage_account_queues  = local.combined_objects_storage_account_queues
  }

}
output "azurerm_eventgrid_system_topic_event_subscription" {
  value = module.azurerm_eventgrid_system_topic_event_subscription
}