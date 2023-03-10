module "web_pubsubs" {
  depends_on = [module.keyvault_access_policies]

  source   = "./modules/messaging/web_pubsub"
  for_each = local.messaging.web_pubsubs

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  location        = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    keyvaults          = local.combined_objects_keyvaults
    resource_groups    = local.combined_objects_resource_groups
    vnets              = local.combined_objects_networking
    private_dns        = local.combined_objects_private_dns
  }
}

output "web_pubsubs" {
  value = module.web_pubsubs
}

module "web_pubsub_hubs" {
  source   = "./modules/messaging/web_pubsub/hub"
  for_each = local.messaging.web_pubsub_hubs

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  remote_objects = {
    managed_identities = local.combined_objects_managed_identities
    resource_groups    = local.combined_objects_resource_groups
    web_pubsubs        = local.combined_objects_web_pubsubs
  }
}

output "web_pubsub_hubs" {
  value = module.web_pubsub_hubs
}
