
terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
  required_version = ">= 0.13"
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
    default_region     = lookup(var.global_settings, "default_region", "region1")
    environment        = lookup(var.global_settings, "environment", var.environment)
    random_length      = lookup(var.global_settings, "random_length", null)
    regions            = var.global_settings.regions
    passthrough        = try(var.global_settings.passthrough, false)
    inherit_tags       = try(var.global_settings.inherit_tags, false)
  }


  compute = {
    virtual_machines           = try(var.compute.virtual_machines, {})
    bastion_hosts              = try(var.compute.bastion_hosts, {})
    azure_container_registries = try(var.compute.azure_container_registries, {})
    aks_clusters               = try(var.compute.aks_clusters, {})
  }

  storage = {
    storage_account_blobs = try(var.storage.storage_account_blobs, {})
  }

  networking = {
    application_gateways                                    = try(var.networking.application_gateways, {})
    application_gateway_applications                        = try(var.networking.application_gateway_applications, {})
    network_security_group_definition                       = try(var.networking.network_security_group_definition, {})
    public_ip_addresses                                     = try(var.networking.public_ip_addresses, {})
    vnet_peerings                                           = try(var.networking.vnet_peerings, {})
    vhub_peerings                                           = try(var.networking.vhub_peerings, {})
    route_tables                                            = try(var.networking.route_tables, {})
    virtual_wans                                            = try(var.networking.virtual_wans, {})
    azurerm_routes                                          = try(var.networking.azurerm_routes, {})
    azurerm_firewalls                                       = try(var.networking.azurerm_firewalls, {})
    azurerm_firewall_network_rule_collection_definition     = try(var.networking.azurerm_firewall_network_rule_collection_definition, {})
    azurerm_firewall_application_rule_collection_definition = try(var.networking.azurerm_firewall_application_rule_collection_definition, {})
    private_dns                                             = try(var.networking.private_dns, {})
    azurerm_firewall_nat_rule_collection_definition         = try(var.networking.azurerm_firewall_nat_rule_collection_definition, {})
    ddos_services                                           = try(var.networking.ddos_services, {})
  }

  database = {
    mssql_servers               = try(var.database.mssql_servers, {})
    mssql_databases             = try(var.database.mssql_databases, {})
    mssql_elastic_pools         = try(var.database.mssql_elastic_pools, {})
    azurerm_redis_caches        = try(var.database.azurerm_redis_caches, {})
    synapse_workspaces          = try(var.database.synapse_workspaces, {})
    databricks_workspaces       = try(var.database.databricks_workspaces, {})
    machine_learning_workspaces = try(var.database.machine_learning_workspaces, {})
  }

  client_config = {
    client_id               = data.azurerm_client_config.current.client_id
    tenant_id               = var.tenant_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    object_id               = data.azurerm_client_config.current.object_id
    logged_aad_app_objectId = var.logged_aad_app_objectId == null ? var.logged_user_objectId == null ? data.azuread_service_principal.logged_in_app.0.object_id : var.logged_user_objectId : var.logged_aad_app_objectId
    logged_user_objectId    = var.logged_user_objectId == null ? var.logged_aad_app_objectId == null ? data.azuread_service_principal.logged_in_app.0.object_id : var.logged_aad_app_objectId : var.logged_user_objectId
    landingzone_key         = var.current_landingzone_key
  }

  webapp = {
    azurerm_application_insights = try(var.webapp.azurerm_application_insights, {})
    app_service_environments     = try(var.webapp.app_service_environments, {})
    app_service_plans            = try(var.webapp.app_service_plans, {})
    app_services                 = try(var.webapp.app_services, {})
  }

  shared_services = {
    recovery_vaults = try(var.shared_services.recovery_vaults, {})
    automations     = try(var.shared_services.automations, {})
    monitoring      = try(var.shared_services.monitoring, {})
  }

  enable = {
    bastion_hosts    = try(var.enable.bastion_hosts, true)
    virtual_machines = try(var.enable.virtual_machines, true)
  }

}

# The rover handle the identity management transition to cover interactive run and execution on pipelines using azure ad applications or managed identities
# There are different scenrios are considered:
#
# 1 - running launchpad from vscode
#  In this bootstrap scenario the launchpad is executed under a logged in user azure session. The rover sets the logged_user_objectId through environment variable. During that initial run an Azure AD application (refered as launchpad_app_level0) is created to support any execution from a pipeline.
# 2 - deploying a landing zone or a solution from vscode
#  Step 1 has been executed. The rover is still connect to a logged in user azure session. The rover use the user's credentials to connect the default azure subscription to identity the storage account and the keyvault holding the tfstate and the launchpad_app_level0 credentials. The rover set the terraform ARM_* variables to change the terraform provider Azure context (client id, secret, tenant and subscription). The logged_aad_app_objectId is set to the launchpad_app_level0's client_id. Note in that scenario the azure session does not change. Meaning when terraform execute some local execution scripts they are executed in the context of the logged_in_user and not the azure ad application. To simulate from vscode the execution of a local exec with the launchpad_app_level0 credentials, the rover must be executed with the parameter --impersonate (cannot be used during the launchpad initial deployment and destruciton)


data "azuread_service_principal" "logged_in_app" {
  count          = var.logged_user_objectId == null ? 1 : 0
  application_id = data.azurerm_client_config.current.client_id
}