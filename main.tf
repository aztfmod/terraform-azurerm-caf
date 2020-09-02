
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
}

provider "azurerm" {
  features {}
}


data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "alpha1" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

locals {
  diagnostics = {
    diagnostics_definition   = lookup(var.diagnostics, "diagnostics_definition", var.diagnostics_definition)
    diagnostics_destinations = lookup(var.diagnostics, "diagnostics_destinations", var.diagnostics_destinations)
    storage_accounts         = lookup(var.diagnostics, "storage_accounts", module.diagnostic_storage_accounts)
    log_analytics            = lookup(var.diagnostics, "log_analytics", module.log_analytics)
  }

  prefix = lookup(var.global_settings, "prefix", null) == null ? random_string.prefix.result : var.global_settings.prefix

  global_settings = {
    prefix             = local.prefix
    prefix_with_hyphen = local.prefix == "" ? "" : "${local.prefix}-"
    prefix_start_alpha = local.prefix == "" ? "" : "${random_string.alpha1.result}${local.prefix}"
    convention         = lookup(var.global_settings, "convention", var.convention)
    default_region     = lookup(var.global_settings, "default_region", "region1")
    environment        = lookup(var.global_settings, "environment", var.environment)
    max_length         = lookup(var.global_settings, "max_length", var.max_length)
    regions            = var.global_settings.regions
  }


  compute = {
    virtual_machines           = try(var.compute.virtual_machines, {})
    bastion_hosts              = try(var.compute.bastion_hosts, {})
    azure_container_registries = try(var.compute.azure_container_registries, {})
  }

  networking = {
    network_security_group_definition                       = try(var.networking.network_security_group_definition, {})
    public_ip_addresses                                     = try(var.networking.public_ip_addresses, {})
    vnet_peerings                                           = try(var.networking.vnet_peerings, {})
    route_tables                                            = try(var.networking.route_tables, {})
    azurerm_routes                                          = try(var.networking.azurerm_routes, {})
    azurerm_firewalls                                       = try(var.networking.azurerm_firewalls, {})
    azurerm_firewall_network_rule_collection_definition     = try(var.networking.azurerm_firewall_network_rule_collection_definition, {})
    azurerm_firewall_application_rule_collection_definition = try(var.networking.azurerm_firewall_application_rule_collection_definition, {})
  }

  database = {
    mssql_servers        = try(var.database.mssql_servers, {})
    azurerm_redis_caches = try(var.database.azurerm_redis_caches, {})
  }

  client_config = {
    client_id               = data.azurerm_client_config.current.client_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    object_id               = data.azurerm_client_config.current.object_id
    logged_aad_app_objectId = var.logged_aad_app_objectId
    logged_user_objectId    = var.logged_user_objectId
  }

}