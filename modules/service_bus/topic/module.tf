resource "azurerm_servicebus_topic" "topic" {
  for_each            = toset(local.topics_list)
  name                = each.key
  resource_group_name = var.resource_group_name
  namespace_name      = var.settings.namespace

  enable_partitioning                     = try(var.settings.topics[each.key].enable_partitioning, null)
  default_message_ttl                     = try(var.settings.topics[each.key].default_message_ttl, null)
  auto_delete_on_idle                     = try(var.settings.topics[each.key].auto_delete_on_idle, null)
  enable_batched_operations               = try(var.settings.topics[each.key].enable_batched_operations, null)
  status                                  = try(var.settings.topics[each.key].status, "Active")
  duplicate_detection_history_time_window = try(var.settings.topics[each.key].duplicate_detection_history_time_window, null)
  enable_express                          = try(var.settings.topics[each.key].enable_express, false)
  max_size_in_megabytes                   = try(var.settings.topics[each.key].max_size_in_megabytes, null)
  requires_duplicate_detection            = try(var.settings.topics[each.key].requires_duplicate_detection, null)
  support_ordering                        = try(var.settings.topics[each.key].support_ordering, null)
}

resource "azurerm_servicebus_topic_authorization_rule" "reader" {
  for_each            = toset(local.topics_reader)
  name                = "${each.key}-reader"
  namespace_name      = var.settings.namespace
  topic_name          = azurerm_servicebus_topic.topic[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "sender" {
  for_each            = toset(local.topics_sender)
  name                = "${each.key}-sender"
  namespace_name      = var.settings.namespace
  topic_name          = azurerm_servicebus_topic.topic[each.key].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_topic_authorization_rule" "manage" {
  for_each            = toset(local.topics_manage)
  name                = "${each.key}-manage"
  namespace_name      = var.settings.namespace
  topic_name          = azurerm_servicebus_topic.topic[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}

resource "azurerm_servicebus_subscription" "subscription" {
  for_each            = toset(local.topics_list)
  name                = each.key
  namespace_name      = var.settings.namespace
  topic_name          = azurerm_servicebus_topic.topic[each.key].name
  resource_group_name = var.resource_group_name

  max_delivery_count                        = try(var.settings.topics[each.key].auto_delete_on_idle, 1)
  auto_delete_on_idle                       = try(var.settings.topics[each.key].auto_delete_on_idle, null)
  default_message_ttl                       = try(var.settings.topics[each.key].default_message_ttl, null)
  enable_batched_operations                 = try(var.settings.topics[each.key].enable_batched_operations, null)
  status                                    = try(var.settings.topics[each.key].status, null)
  forward_dead_lettered_messages_to         = try(var.settings.topics[each.key].forward_dead_lettered_messages_to, null)
  forward_to                                = try(var.settings.topics[each.key].forward_to, null)
  requires_session                          = try(var.settings.topics[each.key].requires_session, null)
  dead_lettering_on_filter_evaluation_error = try(var.settings.topics[each.key].dead_lettering_on_filter_evaluation_error, null)
  dead_lettering_on_message_expiration      = try(var.settings.topics[each.key].dead_lettering_on_message_expiration, null)
  lock_duration                             = try(var.settings.topics[each.key].lock_duration, null)

}