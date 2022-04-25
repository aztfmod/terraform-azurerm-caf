# Digital Twins Instaces
module "digital_twins_instances" {
  source = "./modules/iot/digital_twins/digital_twins_instance"

  for_each = local.iot.digital_twins_instances

  name                = each.value.name
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
  tags                = try(each.value.tags, null)
  global_settings     = local.global_settings
  client_config       = local.client_config
}

output "digital_twins_instances" {
  value = module.digital_twins_instances

}

# Digital Twins  Endpoint Eventhub
module "digital_twins_endpoint_eventhub" {
  source = "./modules/iot/digital_twins/digital_twins_endpoint_eventhub"

  for_each = local.iot.digital_twins_endpoint_eventhubs

  name                                 = each.value.name
  digital_twins_id                     = can(each.value.digital_twins_id) ? each.value.digital_twins_id : local.combined_objects_digital_twins_instances[try(each.value.digital_twins_instance.lz_key, local.client_config.landingzone_key)][try(each.value.digital_twins_instance.key, each.value.digital_twins_instance_key)].id
  eventhub_primary_connection_string   = can(each.value.eventhub_primary_connection_string) ? each.value.eventhub_primary_connection_string : local.combined_objects_event_hub_auth_rules[try(each.value.event_hub_auth_rules.lz_key, local.client_config.landingzone_key)][try(each.value.event_hub_auth_rules.key, each.value.event_hub_auth_rules_key)].primary_connection_string
  eventhub_secondary_connection_string = can(each.value.eventhub_secondary_connection_string) ? each.value.eventhub_secondary_connection_string : local.combined_objects_event_hub_auth_rules[try(each.value.event_hub_auth_rules.lz_key, local.client_config.landingzone_key)][try(each.value.event_hub_auth_rules.key, each.value.event_hub_auth_rules_key)].secondary_connection_string
  global_settings                      = local.global_settings
  client_config                        = local.client_config
}

output "digital_twins_endpoint_eventhub" {
  value = module.digital_twins_endpoint_eventhub

}

module "digital_twins_endpoint_eventgrid" {
  source = "./modules/iot/digital_twins/digital_twins_endpoint_eventgrid"

  for_each = local.iot.digital_twins_endpoint_eventgrids

  name                                 = each.value.name
  digital_twins_id                     = can(each.value.digital_twins_id) ? each.value.digital_twins_id : local.combined_objects_digital_twins_instances[try(each.value.digital_twins_instance.lz_key, local.client_config.landingzone_key)][try(each.value.digital_twins_instance.key, each.value.digital_twins_instance_key)].id
  eventgrid_topic_endpoint             = can(each.value.eventgrid_topic_endpoint) ? each.value.eventgrid_topic_endpoint : local.combined_objects_eventgrid_topics[try(each.value.eventgrid_topic.lz_key, local.client_config.landingzone_key)][try(each.value.eventgrid_topic.key, each.value.eventgrid_topic_key)].endpoint
  eventgrid_topic_primary_access_key   = can(each.value.eventgrid_topic_primary_access_key) ? each.value.eventgrid_topic_primary_access_key : local.combined_objects_eventgrid_topics[try(each.value.eventgrid_topic.lz_key, local.client_config.landingzone_key)][try(each.value.eventgrid_topic.key, each.value.eventgrid_topic_key)].primary_access_key
  eventgrid_topic_secondary_access_key = can(each.value.eventgrid_topic_secondary_access_key) ? each.value.eventgrid_topic_secondary_access_key : local.combined_objects_eventgrid_topics[try(each.value.eventgrid_topic.lz_key, local.client_config.landingzone_key)][try(each.value.eventgrid_topic.key, each.value.eventgrid_topic_key)].eventgrid_topic_secondary_access_key
  global_settings                      = local.global_settings
  client_config                        = local.client_config
}

output "digital_twins_endpoint_eventgrid" {
  value = module.digital_twins_endpoint_eventgrid

}

module "digital_twins_endpoint_servicebus" {
  source = "./modules/iot/digital_twins/digital_twins_endpoint_servicebus"

  for_each = local.iot.digital_twins_endpoint_servicebuses

  name                                   = each.value.name
  digital_twins_id                       = can(each.value.digital_twins_id) ? each.value.digital_twins_id : local.combined_objects_digital_twins_instances[try(each.value.digital_twins_instance.lz_key, local.client_config.landingzone_key)][try(each.value.digital_twins_instance.key, each.value.digital_twins_instance_key)].id
  servicebus_primary_connection_string   = can(each.value.servicebus_primary_connection_string) ? each.value.servicebus_primary_connection_string : local.combined_objects_servicebus_topics[try(each.value.servicebus_topic.lz_key, local.client_config.landingzone_key)][try(each.value.servicebus_topic.key, each.value.servicebus_topic_key)].topic_auth_rules[try(each.value.topic_auth_rules.key, each.value.topic_auth_rules_key)].primary_connection_string
  servicebus_secondary_connection_string = can(each.value.servicebus_secondary_connection_string) ? each.value.servicebus_secondary_connection_string : local.combined_objects_servicebus_topics[try(each.value.servicebus_topic.lz_key, local.client_config.landingzone_key)][try(each.value.servicebus_topic.key, each.value.servicebus_topic_key)].topic_auth_rules[try(each.value.topic_auth_rules.key, each.value.topic_auth_rules_key)].secondary_connection_string
  global_settings                        = local.global_settings
  client_config                          = local.client_config
}

output "digital_twins_endpoint_servicebus" {
  value = module.digital_twins_endpoint_servicebus

}
