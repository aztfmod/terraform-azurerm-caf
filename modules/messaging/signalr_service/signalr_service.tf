# azure_caf
resource "azurecaf_name" "signalr_service" {
  name          = var.settings.name
  resource_type = "azurerm_signalr_service"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_signalr_service" "signalr_service" {
  name                = azurecaf_name.signalr_service.result
  location            = local.location
  resource_group_name = local.resource_group_name
  tags                = merge(local.base_tags, try(var.settings.tags, {}))

  # Shows in documentation but error shows not supported during plan/apply
  connectivity_logs_enabled = try(var.settings.connectivity_logs_enabled, null)
  messaging_logs_enabled    = try(var.settings.messaging_logs_enabled, null)
  service_mode              = try(var.settings.service_mode, null)
  live_trace_enabled        = try(var.settings.live_trace_enabled, null)

  sku {
    name     = var.settings.sku.name
    capacity = var.settings.sku.capacity
  }

  dynamic "cors" {
    for_each = try(var.settings.cors, null) != null ? [1] : []

    content {
      allowed_origins = var.settings.cors.allowed_origins
    }
  }

  # dynamic "features" {
  #   for_each = try(var.settings.features, {})

  #   content {
  #     flag  = features.value.flag
  #     value = features.value.value
  #   }
  # }

  dynamic "upstream_endpoint" {
    for_each = try(var.settings.upstream_endpoints, {})

    content {
      url_template     = upstream_endpoint.value.url_template
      category_pattern = try(upstream_endpoint.value.category_pattern, null)
      event_pattern    = try(upstream_endpoint.value.event_pattern, null)
      hub_pattern      = try(upstream_endpoint.value.hub_pattern, null)
    }
  }

}


resource "azurerm_signalr_service_network_acl" "signalr_network_acl" {
  count = try(var.settings.network_acl, null) != null ? 1 : 0

  signalr_service_id = azurerm_signalr_service.signalr_service.id
  default_action     = var.settings.network_acl.default_action

  public_network {
    allowed_request_types = try(var.settings.network_acl.public_network.allowed_request_types, null)
    denied_request_types  = try(var.settings.network_acl.public_network.denied_request_types, null)
  }


  # dynamic "private_endpoint" {
  #   for_each = try(var.settings.network_acl.private_endpoint, null) != null ? [1] : []

  #   content {
  #     id                    = var.remote_objects.private_endpoint_id
  #     allowed_request_types = try(var.settings.network_acl.private_endpoint.allowed_request_types, null)
  #     denied_request_types  = try(var.settings.network_acl.private_endpoint.denied_request_types, null)
  #   }
  # }

  dynamic "private_endpoint" {
    for_each = try(var.settings.network_acl.private_endpoints, {})

    content {
      id                    = private_endpoint.value.id
      allowed_request_types = try(private_endpoint.value.allowed_request_types, null)
      denied_request_types  = try(private_endpoint.value.denied_request_types, null)
    }
  }

}