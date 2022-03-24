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
  enable_batched_operations               = try(var.settings.enable_batched_operations, null)
  enable_express                          = try(var.settings.enable_express, null)
  enable_partitioning                     = try(var.settings.enable_partitioning, null)
  max_size_in_megabytes                   = try(var.settings.max_size_in_megabytes, null)
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