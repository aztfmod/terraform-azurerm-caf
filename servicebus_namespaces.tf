module "servicebus_namespaces" {
  source = "./modules/servicebus/namespace"
  for_each = local.servicebus.servicebus_namespaces

  global_settings   = local.global_settings
  client_config     = local.client_config
  settings          = each.value

  remote_objects    = {
    resource_groups = local.combined_objects_resource_groups
  }

}
