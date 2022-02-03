module "eventgrid_domains" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain"
  for_each = local.messaging.eventgrid_domains

  resource_group_name                       = local.resource_groups[each.value.resource_group_key].name
  name                                      = each.value.name
  location                                  = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags                                 = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  tags                                      = try(each.value.tags, null)
  global_settings                           = local.global_settings
  client_config                             = local.client_config
  identity                                  = try(each.value.identity, null)
  input_schema                              = try(each.value.input_schema, "EventGridSchema")
  input_mapping_fields                      = try(each.value.input_mapping_fields, null)
  public_network_access_enabled             = try(each.value.public_network_access_enabled, true)
  local_auth_enabled                        = try(each.value.local_auth_enabled, true)
  auto_create_topic_with_first_subscription = try(each.value.auto_create_topic_with_first_subscription, true)
  auto_delete_topic_with_last_subscription  = try(each.value.auto_delete_topic_with_last_subscription, true)
  inbound_ip_rule                           = try(each.value.inbound_ip_rule, [])
  eventgrid_domain_topics                   = try(each.eventgrid_domain_topics, null)
  vnets                                     = local.combined_objects_networking
  subnet_id                                 = try(each.value.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  private_endpoints                         = try(each.value.private_endpoints, {})
  resource_groups                           = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  private_dns                               = local.combined_objects_private_dns

}

output "eventgrid_domains" {
  value = module.eventgrid_domains

}

module "eventgrid_domain_topics" {
  source   = "./modules/messaging/eventgrid/eventgrid_domain_topic"
  for_each = local.messaging.eventgrid_domain_topics

  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  name                = each.value.name
  domain_name         = module.eventgrid_domains[each.value.eventgrid_domain_key].name
  global_settings     = local.global_settings
  client_config       = local.client_config

}

output "eventgrid_domain_topics" {
  value = module.eventgrid_domain_topics

}

module "eventgrid_event_subscriptions" {
  source   = "./modules/messaging/eventgrid/eventgrid_event_subscription"
  for_each = local.messaging.eventgrid_event_subscriptions

  global_settings       = local.global_settings
  client_config         = local.client_config
  name                  = each.value.name
  scope                 = each.value.scope
  expiration_time_utc   = try(each.value.expiration_time_utc, null)
  event_delivery_schema = try(each.value.event_delivery_schema, "EventGridSchema")
  eventhub_endpoint_id = coalesce(
    try(local.combined_objects_event_hubs[each.value.event_hub.lz_key][each.value.event_hub_key].id, null),
    try(local.combined_objects_event_hubs[local.client_config.landingzone_key][each.value.event_hub_key].id, null),
    try(each.value.eventhub_endpoint_id, null)
  )
  /*hybrid_connection_endpoint_id = coalesce(
      try(local.combined_objects_hybrid_connections[each.value.hybrid_connection.lz_key][each.value.hybrid_connection_key].id, null),
      try(local.combined_objects_hybrid_connections[local.client_config.landingzone_key][each.value.hybrid_connection_key].id, null),
	    try(each.value.hybrid_connection_endpoint_id,null)
      )*/


  service_bus_queue_endpoint_id = coalesce(
    try(local.combined_objects_servicebus_queues[each.value.servicebus_queue.lz_key][each.value.servicebus_queue_key].id, null),
    try(local.combined_objects_servicebus_queues[local.client_config.landingzone_key][each.value.servicebus_queue_key].id, null),
    try(each.value.service_bus_queue_endpoint_id, null)
  )
  service_bus_topic_endpoint_id = coalesce(
    try(local.combined_objects_servicebus_topics[each.value.servicebus_topic.lz_key][each.value.servicebus_topic_key].id, null),
    try(local.combined_objects_servicebus_topics[local.client_config.landingzone_key][each.value.servicebus_topic_key].id, null),
    try(each.value.service_bus_topic_endpoint_id, null)
  )

  storage_queue_endpoint = coalesce(
    try(local.combined_objects_storage_account_queues[each.value.storage_queue_endpoint.lz_key][each.value.storage_queue_key].id, null),
    try(local.combined_objects_storage_account_queues[local.client_config.landingzone_key][each.value.storage_queue_key].id, null),
    try(each.value.storage_queue_endpoint, null)
  )
  webhook_endpoint                     = try(each.value.webhook_endpoint, null)
  included_event_types                 = try(each.value.included_event_types, null)
  subject_filter                       = try(each.value.subject_filter, null)
  advanced_filter                      = try(each.value.advanced_filter, null)
  delivery_identity                    = try(each.value.deliver_identity, null)
  delivery_property                    = try(each.value.delivery_property, null)
  dead_letter_identity                 = try(each.value.dead_letter_identity, null)
  retry_policy                         = try(each.value.retry_policy, null)
  labels                               = try(each.value.retry_policy, null)
  advanced_filtering_on_arrays_enabled = try(each.value.retry_policy, null)


}

output "eventgrid_event_subscriptions" {
  value = module.eventgrid_event_subscriptions

}



module "eventgrid_topics" {
  source   = "./modules/messaging/eventgrid/eventgrid_topic"
  for_each = local.messaging.eventgrid_topics

  resource_group_name           = local.resource_groups[each.value.resource_group_key].name
  name                          = each.value.name
  location                      = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags                     = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  tags                          = try(each.value.tags, null)
  global_settings               = local.global_settings
  client_config                 = local.client_config
  identity                      = try(each.value.identity, null)
  input_schema                  = try(each.value.input_schema, "EventGridSchema")
  input_mapping_fields          = try(each.value.input_mapping_fields, null)
  input_mapping_default_values  = try(each.value.input_mapping_default_values, null)
  public_network_access_enabled = try(each.value.public_network_access_enabled, true)
  local_auth_enabled            = try(each.value.local_auth_enabled, true)
  inbound_ip_rule               = try(each.value.inbound_ip_rule, [])
  vnets                         = local.combined_objects_networking
  subnet_id                     = try(each.value.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  private_endpoints             = try(each.value.private_endpoints, {})
  resource_groups               = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  private_dns                   = local.combined_objects_private_dns


}

output "eventgrid_topics" {
  value = module.eventgrid_topics

}