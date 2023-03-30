# naming convention
data "azurecaf_name" "wps" {
  name          = var.settings.name
  resource_type = "azurerm_web_pubsub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Tested with :  AzureRM version 2.99.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/2.99.0/docs/resources/web_pubsub

resource "azurerm_web_pubsub" "wps" {
  name                          = data.azurecaf_name.wps.result
  resource_group_name           = local.resource_group_name
  location                      = local.location
  sku                           = var.settings.sku
  capacity                      = try(var.settings.capacity, null)
  public_network_access_enabled = try(var.settings.public_network_access_enabled, null)
  tags                          = local.tags

  dynamic "live_trace" {
    for_each = lookup(var.settings, "live_trace", {}) == {} ? [] : [1]
    content {
      enabled                   = try(var.settings.live_trace.enabled, null)
      messaging_logs_enabled    = try(var.settings.live_trace.messaging_logs_enabled, null)
      connectivity_logs_enabled = try(var.settings.live_trace.connectivity_logs_enabled, null)
      http_request_logs_enabled = try(var.settings.live_trace.http_request_logs_enabled, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "enable_system_msi", false) == false ? [] : [1]

    content {
      type = "SystemAssigned"
    }
  }

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [var.settings.identity] : []

    content {
      type         = identity.value.type
      identity_ids = local.managed_identities
    }
  }

  local_auth_enabled      = try(var.settings.local_auth_enabled, null)
  aad_auth_enabled        = try(var.settings.aad_auth_enabled, null)
  tls_client_cert_enabled = try(var.settings.tls_client_cert_enabled, null)

  lifecycle {
    ignore_changes = [
      location, resource_group_name
    ]
  }
}
