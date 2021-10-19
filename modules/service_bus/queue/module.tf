resource "azurerm_servicebus_queue" "queue" {
  for_each            = toset(local.queues_list)
  name                = each.key
  resource_group_name = var.resource_group_name
  namespace_name      = var.settings.namespace

  auto_delete_on_idle                     = try(var.settings.queues[each.key].auto_delete_on_idle, null)
  default_message_ttl                     = try(var.settings.queues[each.key].default_message_ttl, null)
  duplicate_detection_history_time_window = try(var.settings.queues[each.key].duplicate_detection_history_time_window, null)
  enable_express                          = try(var.settings.queues[each.key].enable_express, false)
  enable_partitioning                     = try(var.settings.queues[each.key].enable_partitioning, null)
  lock_duration                           = try(var.settings.queues[each.key].lock_duration, null)
  max_size_in_megabytes                   = try(var.settings.queues[each.key].max_size_in_megabytes, null)
  requires_duplicate_detection            = try(var.settings.queues[each.key].requires_duplicate_detection, null)
  requires_session                        = try(var.settings.queues[each.key].requires_session, null)
  dead_lettering_on_message_expiration    = try(var.settings.queues[each.key].dead_lettering_on_message_expiration, null)
  max_delivery_count                      = try(var.settings.queues[each.key].max_delivery_count, null)
}

resource "azurerm_servicebus_queue_authorization_rule" "reader" {
  for_each            = toset(local.queues_reader)
  name                = "${each.key}-reader"
  namespace_name      = var.settings.namespace
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = false
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "sender" {
  for_each            = toset(local.queues_sender)
  name                = "${each.key}-sender"
  namespace_name      = var.settings.namespace
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = false
  send   = true
  manage = false
}

resource "azurerm_servicebus_queue_authorization_rule" "manage" {
  for_each            = toset(local.queues_manage)
  name                = "${each.key}-manage"
  namespace_name      = var.settings.namespace
  queue_name          = azurerm_servicebus_queue.queue[each.key].name
  resource_group_name = var.resource_group_name

  listen = true
  send   = true
  manage = true
}