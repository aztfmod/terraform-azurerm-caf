locals {
  # CAF landing zones can retrieve remote objects from a different landing zone and the 
  # combined_objects will merge it with the local objects 
  combined_objects_keyvaults           = merge(module.keyvaults, try(var.remote_objects.keyvaults, {}))
  combined_objects_networking          = merge(module.networking, try(var.remote_objects.networking, {}))
  combined_objects_private_dns         = merge(module.private_dns, try(var.remote_objects.private_dns, {}))
  combined_objects_public_ip_addresses = merge(module.public_ip_addresses, try(var.remote_objects.public_ip_addresses, {}))
  combined_objects_app_service_plans   = merge(module.app_service_plans, try(var.remote_objects.app_service_plans, {}))
  combined_objects_managed_identities  = merge(module.managed_identities, try(var.remote_objects.managed_identities, {}))
}