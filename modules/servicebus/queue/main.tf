terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }

}

locals {
  resource_group_name = coalesce(
    try(var.remote_objects.resource_groups[var.settings.resource_group.lz_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.resource_groups[var.client_config.landingzone_key][var.settings.resource_group.key].name, null),
    try(var.remote_objects.servicebus_namespaces[var.settings.servicebus_namespace.lz_key][var.settings.servicebus_namespace.key].resource_group_name, null),
    try(var.remote_objects.servicebus_namespaces[var.client_config.landingzone_key][var.settings.servicebus_namespace.key].resource_group_name, null),
  )
  servicebus_namespace_name = coalesce(
    try(var.remote_objects.servicebus_namespaces[var.settings.servicebus_namespace.lz_key][var.settings.servicebus_namespace.key].name, null),
    try(var.remote_objects.servicebus_namespaces[var.client_config.landingzone_key][var.settings.servicebus_namespace.key].name, null),
  )
}