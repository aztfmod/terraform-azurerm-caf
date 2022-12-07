terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.99"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }

}

locals {
  resource_group_name  = can(var.settings.resource_group.key) ? var.remote_objects.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name : var.remote_objects.servicebus_namespaces[try(var.settings.servicebus_namespace.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_namespace.key].resource_group_name
  servicebus_namespace = var.remote_objects.servicebus_namespaces[try(var.settings.servicebus_namespace.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_namespace.key]
}
