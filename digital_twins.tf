# Digital Twins Instaces
module "digital_twins_instance" {
  source = "./modules/iot/digital_twins/digital_twins_instance"

  for_each = local.iot.digital_twins_instances

  resource_group_name        = local.resource_groups[each.value.resource_group_key].name
  name            = each.value.name
  location                   = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags                  = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  tags                       = try(each.value.tags, null)
  global_settings            = local.global_settings  
  client_config       = local.client_config
}

output "digital_twins_instances" {
  value = module.digital_twins_instances

}

# Digital Twins  Endpoint Eventhub
module "digital_twins_endpoint_eventhub" {
  source = "./modules/iot/digital_twins/digital_twins_endpoint_eventhub"

  for_each = local.iot.digital_twins_endpoint_eventhubs

  name            = each.value.name
  digital_twins_id  = try(each.value.lz_key, null) == null ? local.combined_objects_digital_twins_instances[local.client_config.landingzone_key][each.value.digital_twins_instance_key].id : local.combined_objects_digital_twins_instances[each.value.lz_key][each.value.digital_twins_instance_key].id
  eventhub_primary_connection_string  = module.event_hub_auth_rules[each.value.event_hub_auth_rules_key].primary_connection_string
  eventhub_secondary_connection_string  = module.event_hub_auth_rules[each.value.event_hub_auth_rules_key].primary_connection_string
  depends_on = [
    module.digital_twins_instance
  ]
}


#resource "azurerm_digital_twins_endpoint_eventhub" "example" {
#  name                                 = "example-EH"
#  digital_twins_id                     = azurerm_digital_twins_instance.example.id
#  eventhub_primary_connection_string   = azurerm_eventhub_authorization_rule.example.primary_connection_string
#  eventhub_secondary_connection_string = azurerm_eventhub_authorization_rule.example.secondary_connection_string
#}

#resource "azurerm_digital_twins_endpoint_eventgrid" "example" {
#  name                                 = "example-EG"
#  digital_twins_id                     = azurerm_digital_twins_instance.example.id
#  eventgrid_topic_endpoint             = azurerm_eventgrid_topic.example.endpoint
#  eventgrid_topic_primary_access_key   = azurerm_eventgrid_topic.example.primary_access_key
#  eventgrid_topic_secondary_access_key = azurerm_eventgrid_topic.example.secondary_access_key
#}

#resource "azurerm_digital_twins_endpoint_servicebus" "example" {
#  name                                   = "example-EndpointSB"
#  digital_twins_id                       = azurerm_digital_twins_instance.example.id
#  servicebus_primary_connection_string   = azurerm_servicebus_topic_authorization_rule.example.primary_connection_string
#  servicebus_secondary_connection_string = azurerm_servicebus_topic_authorization_rule.example.secondary_connection_string
#}
