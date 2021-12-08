module "servicebus_queues" {
  depends_on = [module.servicebus_namespaces]
  source     = "./modules/servicebus/queue"
  for_each   = local.servicebus.servicebus_queues

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    resource_groups       = local.combined_objects_resource_groups
    servicebus_namespaces = local.combined_objects_servicebus_namespaces
    servicebus_queues     = var.remote_objects.servicebus_queues
    servicebus_topics     = var.remote_objects.servicebus_topics
  }
}

output "servicebus_queues" {
  value = module.servicebus_queues
}