module "maintenance_configuration" {
  source   = "./modules/maintenance/configuration"
  for_each = local.maintenance.maintenance_configuration

  client_config            = local.client_config
  global_settings          = local.global_settings
  settings                 = each.value
  name                     = each.value.name
  location                 = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  scope                    = each.value.scope
  in_guest_user_patch_mode = each.value.scope == "InGuestPatch" ? each.value.in_guest_user_patch_mode : null
  window                   = try(each.value.window, null)
  install_patches          = each.value.scope == "InGuestPatch" ? try(each.value.install_patches, null) : null
  visibility               = try(each.value.visibility, null)
  properties               = try(each.value.properties, {})
  base_tags                = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  tags                     = try(each.value.tags, {})
}

output "maintenance_configuration" {
  value = module.maintenance_configuration
}

module "maintenance_assignment_virtual_machine" {
  source   = "./modules/maintenance/assignment_virtual_machine"
  for_each = local.maintenance.maintenance_assignment_virtual_machine

  client_config                = local.client_config
  global_settings              = local.global_settings
  location                     = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  maintenance_configuration_id = can(each.value.maintenance_configuration_id) ? each.value.maintenance_configuration_id : local.combined_objects_maintenance_configuration[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.maintenance_configuration_key].id
  virtual_machine_id           = local.combined_objects_virtual_machines[try(each.value.virtual_machine.lz_key, local.client_config.landingzone_key)][try(each.value.virtual_machine.key, each.value.virtual_machine_key)].id
}

output "maintenance_assignment_virtual_machine" {
  value = module.maintenance_assignment_virtual_machine
}






