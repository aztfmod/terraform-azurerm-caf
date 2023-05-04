module "servicebus_subscriptions" {
  source   = "./subscription"
  for_each = try(var.settings.subscriptions, {})

  global_settings = var.global_settings
  client_config   = var.client_config
  settings        = each.value

  remote_objects = {
    servicebus_topic_id     = azurerm_servicebus_topic.topic.id
    servicebus_namespace_id = local.servicebus_namespace.id
    resource_group_name     = local.resource_group_name
    servicebus_queues       = try(var.remote_objects.servicebus_queues, null)
    servicebus_topics       = try(var.remote_objects.servicebus_topics, null)
  }

}

output "servicebus_subscriptions" {
  value = module.servicebus_subscriptions
}