terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}
locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.base_tags, local.module_tag, try(var.settings.tags, null))

  managed_local_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.remote_objects.managed_identities[var.client_config.landingzone_key][managed_identity_key].id
    ]
  ])

  managed_remote_identities = flatten([
    for lz_key, value in try(var.settings.identity.remote, []) : [
      for managed_identity_key in value.managed_identity_keys : [
        var.remote_objects.managed_identities[lz_key][managed_identity_key].id
      ]
    ]
  ])

  provided_identities = try(var.settings.identity.managed_identity_ids, [])
  managed_identities  = concat(local.provided_identities, local.managed_local_identities, local.managed_remote_identities)

  resource_group_name = coalesce(try(var.settings.resource_group.name, null), try(var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name, null), try(var.remote_objects[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].resource_group_name, null))

  location            = coalesce(try(var.settings.location, null), try(var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][try(var.settings.resource_group.key, var.settings.resource_group_key)].location, null), try(var.remote_objects[var.settings.topic.resource_type][try(var.settings.topic.lz_key, var.client_config.landingzone_key)][var.settings.topic.resource_key].location, null), "global")

}