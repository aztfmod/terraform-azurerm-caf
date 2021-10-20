module "servicebus_queues" {
  depends_on = [module.servicebus_namespaces]
  source = "./modules/servicebus/queue"
  for_each = local.servicebus.servicebus_queues

  global_settings   = local.global_settings
  client_config     = local.client_config
  settings          = each.value

  remote_objects    = {
    resource_groups       = local.combined_objects_resource_groups
    servicebus_namespaces = local.combined_objects_servicebus_namespaces
    # servicebus_topics     = local.combined_objects_servicebus_topics
    # servicebus_queues     = local.combined_objects_servicebus_queues # cycle error:unable to self reference
  }
}

output "servicebus_queues" {
  value = module.servicebus_queues
}