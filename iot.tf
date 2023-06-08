module "iot_hub" {
  source   = "./modules/iot/iot_hub"
  for_each = local.iot.iot_hub

  global_settings     = local.global_settings
  client_config       = local.client_config
  base_tags           = local.global_settings.inherit_tags
  location            = try(local.global_settings.regions[each.value.region], null)
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  settings            = each.value

  remote_objects = {
    resource_groups      = local.combined_objects_resource_groups
    managed_identities   = local.combined_objects_managed_identities
    event_hub_namespaces = local.combined_objects_event_hub_namespaces
    event_hubs           = local.combined_objects_event_hubs
    event_hub_auth_rules = local.combined_objects_event_hub_auth_rules
    storage_accounts     = local.combined_objects_storage_accounts
  }
}

output "iot_hub" {
  value = module.iot_hub
}

module "iot_hub_consumer_groups" {
  source   = "./modules/iot/consumer_groups"
  for_each = local.iot.iot_hub_consumer_groups

  global_settings     = local.global_settings
  settings            = each.value
  iothub_name         = local.combined_objects_iot_hub[try(each.value.iot_hub.lz_key, local.client_config.landingzone_key)][each.value.iot_hub.key].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_hub_consumer_groups" {
  value = module.iot_hub_consumer_groups
}

module "iot_hub_certificate" {
  source   = "./modules/iot/iot_hub/certificate"
  for_each = local.iot.iot_hub_certificate

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  iothub_name         = local.combined_objects_iot_hub[try(each.value.iot_hub.lz_key, local.client_config.landingzone_key)][each.value.iot_hub.key].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  keyvaults           = local.combined_objects_keyvaults
}

output "iot_hub_certificate" {
  value = module.iot_hub_certificate
}

module "iot_hub_shared_access_policy" {
  source   = "./modules/iot/iot_hub/shared_access_policy"
  for_each = local.iot.iot_hub_shared_access_policy

  global_settings     = local.global_settings
  settings            = each.value
  iothub_name         = local.combined_objects_iot_hub[try(each.value.iot_hub.lz_key, local.client_config.landingzone_key)][each.value.iot_hub.key].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_hub_shared_access_policy" {
  value = module.iot_hub_shared_access_policy
}

module "iot_hub_dps" {
  source   = "./modules/iot/iot_hub_dps"
  for_each = local.iot.iot_hub_dps

  global_settings     = local.global_settings
  client_config       = local.client_config
  base_tags           = local.global_settings.inherit_tags
  location            = try(local.global_settings.regions[each.value.region], null)
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  settings            = each.value

  remote_objects = {
    iot_hub                      = local.combined_objects_iot_hub
    iot_hub_shared_access_policy = local.combined_objects_iot_hub_shared_access_policy
  }
}

output "iot_hub_dps" {
  value = module.iot_hub_dps
}

module "iot_dps_certificate" {
  source   = "./modules/iot/iot_hub_dps/dps_certificate"
  for_each = local.iot.iot_dps_certificate

  settings            = each.value
  global_settings     = local.global_settings
  iot_dps_name        = local.combined_objects_iot_hub_dps[try(each.value.iot_hub_dps.lz_key, local.client_config.landingzone_key)][each.value.iot_hub_dps.key].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_dps_certificate" {
  value = module.iot_dps_certificate
}

module "iot_dps_shared_access_policy" {
  source   = "./modules/iot/iot_hub_dps/shared_access_policy"
  for_each = local.iot.iot_dps_shared_access_policy

  global_settings     = local.global_settings
  settings            = each.value
  iot_dps_name        = local.combined_objects_iot_hub_dps[try(each.value.iot_hub_dps.lz_key, local.client_config.landingzone_key)][each.value.iot_hub_dps.key].name
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_dps_shared_access_policy" {
  value = module.iot_dps_shared_access_policy
}

module "iot_central_application" {
  source   = "./modules/iot/iot_central_application"
  for_each = local.iot.iot_central_application

  global_settings     = local.global_settings
  settings            = each.value
  base_tags           = local.global_settings.inherit_tags
  location            = try(local.global_settings.regions[each.value.region], null)
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_central_application" {
  value = module.iot_central_application
}

module "iot_security_solution" {
  source   = "./modules/iot/security/security_solution"
  for_each = local.iot.iot_security_solution

  global_settings = local.global_settings
  settings        = each.value
  iothub_ids = try(
    each.value.iot_hub_ids,
    [for key, value in try(each.value.iot_hub, {}) : local.combined_objects_iot_hub[try(value.lz_key, local.client_config.landingzone_key)][value.key].id]
  )

  base_tags           = local.global_settings.inherit_tags
  location            = try(local.global_settings.regions[each.value.region], null)
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
}

output "iot_security_solution" {
  value = module.iot_security_solution
}

module "iot_security_device_group" {
  source   = "./modules/iot/security/device_group"
  for_each = local.iot.iot_security_device_group

  global_settings = local.global_settings
  settings        = each.value
  iothub_id       = local.combined_objects_iot_hub[try(each.value.iot_hub.lz_key, local.client_config.landingzone_key)][each.value.iot_hub.key].id

  depends_on = [
    module.iot_security_solution
  ]
}

output "iot_security_device_group" {
  value = module.iot_security_device_group
}
