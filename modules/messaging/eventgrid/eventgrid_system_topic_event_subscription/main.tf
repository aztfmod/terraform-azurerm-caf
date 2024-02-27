terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}


locals {
    system_topic = coalesce(try(var.settings.scope.id, null), try(var.remote_objects.eventgrid_system_topics[try(var.settings.scope.lz_key, var.client_config.landingzone_key)][var.settings.scope.key].name, null))
    resource_group_name = coalesce(try(var.settings.resource_group.name, null), try(var.remote_objects.all.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name, null), try(var.remote_objects.eventgrid_system_topics[try(var.settings.scope.lz_key, var.client_config.landingzone_key)][var.settings.scope.key].resource_group_name, null))
}