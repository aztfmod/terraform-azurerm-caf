
data "azurecaf_name" "hub" {
  name          = var.settings.name
  resource_type = "azurerm_web_pubsub_hub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_web_pubsub_hub" "hub" {
  name          = data.azurecaf_name.hub.result
  web_pubsub_id = can(var.settings.web_pubsub_id) ? var.settings.web_pubsub_id : var.remote_objects.web_pubsubs[try(var.settings.web_pubsub.lz_key, var.client_config.landingzone_key)][var.settings.web_pubsub.key].id

  dynamic "event_handler" {
    for_each = var.settings.event_handler
    content {
      url_template       = event_handler.value.url_template
      user_event_pattern = try(event_handler.value.user_event_pattern, null)
      system_events      = try(event_handler.value.system_events, null)
      dynamic "auth" {
        for_each = try(event_handler.value.auth, null) == null ? [] : [1]
        content {
          managed_identity_id = can(event_handler.value.auth.managed_identity_id) ? event_handler.value.auth.managed_identity_id : var.remote_objects.managed_identities[var.client_config.landingzone_key][event_handler.value.auth.managed_identity_key].id
        }
      }
    }
  }

  anonymous_connections_enabled = try(var.settings.anonymous_connections_enabled, null)
}