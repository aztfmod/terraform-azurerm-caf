resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                                                      = var.settings.name
  cdn_frontdoor_profile_id                                  = var.cdn_frontdoor_profile_id
  session_affinity_enabled                                  = try(var.settings.session_affinity_enabled, null)
  restore_traffic_time_to_healed_or_new_endpoint_in_minutes = try(var.settings.restore_traffic_time, null)

  dynamic "health_probe" {
    for_each = try(var.settings.health_probe, {})
    content {
      interval_in_seconds = try(health_probe.value.interval_in_seconds, null)
      path                = try(health_probe.value.path, null)
      protocol            = try(health_probe.value.protocol, null)
      request_type        = try(health_probe.value.request_type, null)
    }
  }

  dynamic "load_balancing" {
    for_each = try(var.settings.load_balancing, {})
    content {
      additional_latency_in_milliseconds = try(load_balancing.additional_latency, null)
      sample_size                        = try(load_balancing.sample_size, null)
      successful_samples_required        = try(load_balancing.successful_samples_required, null)
    }
  }
}