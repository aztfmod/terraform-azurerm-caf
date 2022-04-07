module "servicebus_queues" {
  depends_on = [module.servicebus_namespaces]
  source     = "./modules/messaging/servicebus/queue"
  for_each   = local.messaging.servicebus_queues

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    resource_groups       = local.combined_objects_resource_groups
    servicebus_namespaces = local.combined_objects_servicebus_namespaces
    servicebus_queues     = try(var.remote_objects.servicebus_queues, null)
    servicebus_topics     = try(var.remote_objects.servicebus_topics, null)
  }
}

output "servicebus_queues" {
  value = module.servicebus_queues
}