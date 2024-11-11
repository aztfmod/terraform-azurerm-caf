
resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = var.settings.name
  cdn_frontdoor_endpoint_id     = var.cdn_frontdoor_endpoint_id
  cdn_frontdoor_origin_group_id = var.cdn_frontdoor_origin_group_id
  cdn_frontdoor_origin_ids      = var.cdn_frontdoor_origin_ids
  cdn_frontdoor_rule_set_ids    = var.cdn_frontdoor_rule_set_ids
  enabled                       = try(var.settings.enabled, null)

  forwarding_protocol    = try(var.settings.forwarding_protocol, null)
  https_redirect_enabled = try(var.settings.https_redirect_enabled, null)
  patterns_to_match      = try(var.settings.patterns_to_match, [])
  supported_protocols    = try(var.settings.supported_protocols, [])

  cdn_frontdoor_custom_domain_ids = var.cdn_frontdoor_custom_domain_ids

  dynamic "cache" {
    for_each = try(var.settings.cache, null) == null ? [] : [var.settings.cache]
    content {
      query_string_caching_behavior = try(cache.value.query_string_caching_behavior, null)
      query_strings                 = try(cache.value.query_strings, null)
      compression_enabled           = try(cache.value.compression_enabled, null)
      content_types_to_compress     = try(cache.value.content_types_to_compress, null)
    }
  }
}