resource "azurecaf_name" "topic" {
  name          = var.settings.name
  resource_type = "azurerm_servicebus_topic"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_servicebus_topic" "topic" {
  auto_delete_on_idle                     = try(var.settings.auto_delete_on_idle, null)
  default_message_ttl                     = try(var.settings.default_message_ttl, null)
  duplicate_detection_history_time_window = try(var.settings.duplicate_detection_history_time_window, null)
  batched_operations_enabled              = try(var.settings.batched_operations_enabled, null)
  express_enabled                         = try(var.settings.express_enabled, null)
  partitioning_enabled                    = try(var.settings.partitioning_enabled, null)
  max_size_in_megabytes                   = try(var.settings.max_size_in_megabytes, null)
  max_message_size_in_kilobytes           = try(var.settings.max_message_size_in_kilobytes, null)
  name                                    = azurecaf_name.topic.result
  namespace_id                            = local.servicebus_namespace.id
  requires_duplicate_detection            = try(var.settings.requires_duplicate_detection, null)
  support_ordering                        = try(var.settings.support_ordering, null)
}

module "topic_auth_rules" {
  source   = "./topic_auth_rule"
  for_each = try(var.settings.topic_auth_rules, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_topic_id     = azurerm_servicebus_topic.topic.id
    servicebus_namespace_id = local.servicebus_namespace.id
    resource_group_name     = local.resource_group_name
  }

}