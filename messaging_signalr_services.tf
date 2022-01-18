module "signalr_services" {
  source   = "./modules/messaging/signalr_service"
  for_each = local.messaging.signalr_services

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    resource_groups = local.combined_objects_resource_groups
    vnets           = local.combined_objects_networking
  }
}

output "signalr_services" {
  value = module.signalr_services
}