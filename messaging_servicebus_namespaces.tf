module "servicebus_namespaces" {
  depends_on = [module.networking]
  source     = "./modules/messaging/servicebus/namespace"
  for_each   = local.messaging.servicebus_namespaces

  base_tags       = local.global_settings.inherit_tags
  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_groups = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]

  remote_objects = {
    resource_groups = local.combined_objects_resource_groups
    vnets           = local.combined_objects_networking
    private_dns     = local.combined_objects_private_dns
  }

}

output "servicebus_namespaces" {
  value = module.servicebus_namespaces
}
