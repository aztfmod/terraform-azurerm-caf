module "servicebus_namespaces" {
  depends_on = [module.networking]
  source     = "./modules/messaging/servicebus/namespace"
  for_each   = local.messaging.servicebus_namespaces

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_groups = local.combined_objects_resource_groups

  remote_objects = {
    resource_groups = local.combined_objects_resource_groups
    vnets           = local.combined_objects_networking
    private_dns     = local.combined_objects_private_dns
  }

}

output "servicebus_namespaces" {
  value = module.servicebus_namespaces
}
