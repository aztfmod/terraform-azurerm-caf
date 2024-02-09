
# resource "azurecaf_name" "egstes" {
#   name          = var.settings.name
#   resource_type = "azurerm_eventgrid_event_subscription"
#   prefixes      = var.global_settings.prefixes
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }
resource "azurerm_eventgrid_system_topic_event_subscription" "egstes" {
  name                 = var.settings.name
  resource_group_name  = can(var.settings.resource_group.name) ? var.settings.resource_group.name : var.remote_objects.resource_group[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name
  system_topic         = can(var.settings.eventgrid_domain.name) ? var.settings.eventgrid_domain.name : var.remote_objects.eventgrid_domains[try(var.settings.eventgrid_domain.lz_key, var.client_config.landingzone_key)][var.settings.eventgrid_domain.key].name

  dynamic "webhook_endpoint" {
    for_each = try(var.settings.webhook_endpoint, null) != null ? [var.settings.webhook_endpoint] : []
    content {
      url                               = try(webhook_endpoint.value.url, null)
      base_url                          = try(webhook_endpoint.value.base_url, null)
      max_events_per_batch              = try(webhook_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(webhook_endpoint.value.preferred_batch_size_in_kilobytes, null)
      active_directory_tenant_id        = try(webhook_endpoint.value.active_directory_tenant_id, null)
      active_directory_app_id_or_uri    = try(webhook_endpoint.value.active_directory_app_id_or_uri, null)
    }
  }
  included_event_types = try(var.settings.included_event_types, null)
}
