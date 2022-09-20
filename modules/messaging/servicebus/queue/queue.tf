resource "azurecaf_name" "queue" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_queue"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_queue" "queue" {
  auto_delete_on_idle                     = try(var.settings.auto_delete_on_idle, null)
  dead_lettering_on_message_expiration    = try(var.settings.dead_lettering_on_message_expiration, null)
  default_message_ttl                     = try(var.settings.default_message_ttl, null)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, null)
  enable_batched_operations               = try(var.settings.enable_batched_operations, null)
  enable_express                          = try(var.settings.enable_express, null)
  enable_partitioning                     = try(var.settings.enable_partitioning, null)
  lock_duration                           = try(var.settings.lock_duration, null)
  max_delivery_count                      = try(var.settings.max_delivery_count, null)
  max_size_in_megabytes                   = try(var.settings.max_size_in_megabytes, null)
  name                                    = azurecaf_name.queue.result
  namespace_id                            = local.servicebus_namespace.id
  requires_duplicate_detection            = try(var.settings.requires_duplicate_detection, null)
  requires_session                        = try(var.settings.requires_session, null)
  # resource_group_name                     = local.resource_group_name
  status = try(var.settings.status, null)

  forward_to = try(coalesce(
    try(var.settings.forward_to.queue.name, null),
    try(var.settings.forward_to.topic.name, null),
    try(var.remote_objects.servicebus_queues[var.settings.forward_to.queue.lz_key][var.settings.forward_to.queue.key].name, null),
    try(var.remote_objects.servicebus_topics[var.settings.forward_to.topic.lz_key][var.settings.forward_to.topic.key].name, null),
  ), null)
  forward_dead_lettered_messages_to = try(coalesce(
    try(var.settings.forward_dead_lettered_messages_to.name, null),
    try(var.settings.forward_dead_lettered_messages_to.name, null),
    try(var.remote_objects.servicebus_queues[var.settings.forward_dead_lettered_messages_to.queue.lz_key][var.settings.forward_dead_lettered_messages_to.queue.key].name, null),
    try(var.remote_objects.servicebus_topics[var.settings.forward_dead_lettered_messages_to.topic.lz_key][var.settings.forward_dead_lettered_messages_to.topic.key].name, null),
  ), null)
}

module "queue_auth_rules" {
  source   = "./queue_auth_rule"
  for_each = try(var.settings.queue_auth_rules, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_queue_id     = azurerm_servicebus_queue.queue.id
    servicebus_namespace_id = local.servicebus_namespace.id
    resource_group_name     = local.resource_group_name
  }

}