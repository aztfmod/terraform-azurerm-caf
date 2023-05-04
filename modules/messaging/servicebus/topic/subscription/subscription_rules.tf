module "correlation_filter_rules" {
  source   = "./subscription_rule/correlation_filter"
  for_each = try(var.settings.subscription_rules.correlation_filter_rules, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_subscription_id = azurerm_servicebus_subscription.subscription.id
    # servicebus_topic_name      = var.remote_objects.servicebus_topic_name
    # servicebus_namespace_id    = var.remote_objects.servicebus_namespace_id
    # resource_group_name        = var.remote_objects.resource_group_name
  }
}

module "sql_filter_rules" {
  source   = "./subscription_rule/sql_filter"
  for_each = try(var.settings.subscription_rules.sql_filter_rules, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_subscription_id = azurerm_servicebus_subscription.subscription.id
    # servicebus_topic_name      = var.remote_objects.servicebus_topic_name
    # servicebus_namespace_id    = var.remote_objects.servicebus_namespace_id
    # resource_group_name        = var.remote_objects.resource_group_name
  }
}
