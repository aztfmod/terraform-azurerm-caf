
resource "azurecaf_name" "cdn" {
  name          = var.settings.name
  resource_type = "azurerm_cdn_endpoint"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_cdn_endpoint" "cdn" {
  name                      = azurecaf_name.cdn.result
  resource_group_name       = var.resource_group_name
  profile_name              = var.remote_objects.profile_name
  location                  = var.location
  is_http_allowed           = try(var.settings.is_http_allowed, null)
  is_https_allowed          = try(var.settings.is_https_allowed, null)
  content_types_to_compress = try(var.settings.content_types_to_compress, null)
  dynamic "geo_filter" {
    for_each = try(var.settings.geo_filter, null) != null ? [var.settings.geo_filter] : []
    content {
      relative_path = try(geo_filter.value.relative_path, null)
      action        = try(geo_filter.value.action, null)
      country_codes = try(geo_filter.value.country_codes, null)
    }
  }
  is_compression_enabled        = try(var.settings.is_compression_enabled, null)
  querystring_caching_behaviour = try(var.settings.querystring_caching_behaviour, null)
  optimization_type             = try(var.settings.optimization_type, null)
  dynamic "origin" {
    for_each = try(var.settings.origin, null) != null ? [var.settings.origin] : []
    content {
      name       = try(origin.value.name, null)
      host_name  = try(origin.value.host_name, null)
      http_port  = try(origin.value.http_port, null)
      https_port = try(origin.value.https_port, null)
    }
  }
  origin_host_header = try(var.settings.origin_host_header, null)
  origin_path        = try(var.settings.origin_path, null)
  probe_path         = try(var.settings.probe_path, null)
  dynamic "global_delivery_rule" {
    for_each = try(var.settings.global_delivery_rule, null) != null ? [var.settings.global_delivery_rule] : []
    content {
      dynamic "cache_expiration_action" {
        for_each = try(var.settings.cache_expiration_action, null) != null ? [var.settings.cache_expiration_action] : []
        content {
          behavior = try(cache_expiration_action.value.behavior, null)
          duration = try(cache_expiration_action.value.duration, null)
        }
      }
      dynamic "cache_key_query_string_action" {
        for_each = try(var.settings.cache_key_query_string_action, null) != null ? [var.settings.cache_key_query_string_action] : []
        content {
          behavior   = try(cache_key_query_string_action.value.behavior, null)
          parameters = try(cache_key_query_string_action.value.parameters, null)
        }
      }
      dynamic "modify_request_header_action" {
        for_each = try(var.settings.modify_request_header_action, null) != null ? [var.settings.modify_request_header_action] : []
        content {
          action = try(modify_request_header_action.value.action, null)
          name   = try(modify_request_header_action.value.name, null)
          value  = try(modify_request_header_action.value.value, null)
        }
      }
      dynamic "modify_response_header_action" {
        for_each = try(var.settings.modify_response_header_action, null) != null ? [var.settings.modify_response_header_action] : []
        content {
          action = try(modify_response_header_action.value.action, null)
          name   = try(modify_response_header_action.value.name, null)
          value  = try(modify_response_header_action.value.value, null)
        }
      }
      dynamic "url_redirect_action" {
        for_each = try(var.settings.url_redirect_action, null) != null ? [var.settings.url_redirect_action] : []
        content {
          redirect_type = try(url_redirect_action.value.redirect_type, null)
          protocol      = try(url_redirect_action.value.protocol, null)
          hostname      = try(url_redirect_action.value.hostname, null)
          path          = try(url_redirect_action.value.path, null)
          fragment      = try(url_redirect_action.value.fragment, null)
          query_string  = try(url_redirect_action.value.query_string, null)
        }
      }
      dynamic "url_rewrite_action" {
        for_each = try(var.settings.url_rewrite_action, null) != null ? [var.settings.url_rewrite_action] : []
        content {
          source_pattern          = try(url_rewrite_action.value.source_pattern, null)
          destination             = try(url_rewrite_action.value.destination, null)
          preserve_unmatched_path = try(url_rewrite_action.value.preserve_unmatched_path, null)
        }
      }
    }
  }
  dynamic "delivery_rule" {
    for_each = try(var.settings.delivery_rule, null) != null ? [var.settings.delivery_rule] : []
    content {
      name  = try(delivery_rule.value.name, null)
      order = try(delivery_rule.value.order, null)
      dynamic "cache_expiration_action" {
        for_each = try(var.settings.cache_expiration_action, null) != null ? [var.settings.cache_expiration_action] : []
        content {
          behavior = try(cache_expiration_action.value.behavior, null)
          duration = try(cache_expiration_action.value.duration, null)
        }
      }
      dynamic "cache_key_query_string_action" {
        for_each = try(var.settings.cache_key_query_string_action, null) != null ? [var.settings.cache_key_query_string_action] : []
        content {
          behavior   = try(cache_key_query_string_action.value.behavior, null)
          parameters = try(cache_key_query_string_action.value.parameters, null)
        }
      }
      dynamic "cookies_condition" {
        for_each = try(var.settings.cookies_condition, null) != null ? [var.settings.cookies_condition] : []
        content {
          selector         = try(cookies_condition.value.selector, null)
          operator         = try(cookies_condition.value.operator, null)
          negate_condition = try(cookies_condition.value.negate_condition, null)
          match_values     = try(cookies_condition.value.match_values, null)
          transforms       = try(cookies_condition.value.transforms, null)
        }
      }
      dynamic "device_condition" {
        for_each = try(var.settings.device_condition, null) != null ? [var.settings.device_condition] : []
        content {
          operator         = try(device_condition.value.operator, null)
          negate_condition = try(device_condition.value.negate_condition, null)
          match_values     = try(device_condition.value.match_values, null)
        }
      }
      dynamic "http_version_condition" {
        for_each = try(var.settings.http_version_condition, null) != null ? [var.settings.http_version_condition] : []
        content {
          operator         = try(http_version_condition.value.operator, null)
          negate_condition = try(http_version_condition.value.negate_condition, null)
          match_values     = try(http_version_condition.value.match_values, null)
        }
      }
      dynamic "modify_request_header_action" {
        for_each = try(var.settings.modify_request_header_action, null) != null ? [var.settings.modify_request_header_action] : []
        content {
          action = try(modify_request_header_action.value.action, null)
          name   = try(modify_request_header_action.value.name, null)
          value  = try(modify_request_header_action.value.value, null)
        }
      }
      dynamic "modify_response_header_action" {
        for_each = try(var.settings.modify_response_header_action, null) != null ? [var.settings.modify_response_header_action] : []
        content {
          action = try(modify_response_header_action.value.action, null)
          name   = try(modify_response_header_action.value.name, null)
          value  = try(modify_response_header_action.value.value, null)
        }
      }
      dynamic "post_arg_condition" {
        for_each = try(var.settings.post_arg_condition, null) != null ? [var.settings.post_arg_condition] : []
        content {
          selector         = try(post_arg_condition.value.selector, null)
          operator         = try(post_arg_condition.value.operator, null)
          negate_condition = try(post_arg_condition.value.negate_condition, null)
          match_values     = try(post_arg_condition.value.match_values, null)
          transforms       = try(post_arg_condition.value.transforms, null)
        }
      }
      dynamic "query_string_condition" {
        for_each = try(var.settings.query_string_condition, null) != null ? [var.settings.query_string_condition] : []
        content {
          operator         = try(query_string_condition.value.operator, null)
          negate_condition = try(query_string_condition.value.negate_condition, null)
          match_values     = try(query_string_condition.value.match_values, null)
          transforms       = try(query_string_condition.value.transforms, null)
        }
      }
      dynamic "remote_address_condition" {
        for_each = try(var.settings.remote_address_condition, null) != null ? [var.settings.remote_address_condition] : []
        content {
          operator         = try(remote_address_condition.value.operator, null)
          negate_condition = try(remote_address_condition.value.negate_condition, null)
          match_values     = try(remote_address_condition.value.match_values, null)
        }
      }
      dynamic "request_body_condition" {
        for_each = try(var.settings.request_body_condition, null) != null ? [var.settings.request_body_condition] : []
        content {
          operator         = try(request_body_condition.value.operator, null)
          negate_condition = try(request_body_condition.value.negate_condition, null)
          match_values     = try(request_body_condition.value.match_values, null)
          transforms       = try(request_body_condition.value.transforms, null)
        }
      }
      dynamic "request_header_condition" {
        for_each = try(var.settings.request_header_condition, null) != null ? [var.settings.request_header_condition] : []
        content {
          selector         = try(request_header_condition.value.selector, null)
          operator         = try(request_header_condition.value.operator, null)
          negate_condition = try(request_header_condition.value.negate_condition, null)
          match_values     = try(request_header_condition.value.match_values, null)
          transforms       = try(request_header_condition.value.transforms, null)
        }
      }
      dynamic "request_method_condition" {
        for_each = try(var.settings.request_method_condition, null) != null ? [var.settings.request_method_condition] : []
        content {
          operator         = try(request_method_condition.value.operator, null)
          negate_condition = try(request_method_condition.value.negate_condition, null)
          match_values     = try(request_method_condition.value.match_values, null)
        }
      }
      dynamic "request_scheme_condition" {
        for_each = try(var.settings.request_scheme_condition, null) != null ? [var.settings.request_scheme_condition] : []
        content {
          operator         = try(request_scheme_condition.value.operator, null)
          negate_condition = try(request_scheme_condition.value.negate_condition, null)
          match_values     = try(request_scheme_condition.value.match_values, null)
        }
      }
      dynamic "request_uri_condition" {
        for_each = try(var.settings.request_uri_condition, null) != null ? [var.settings.request_uri_condition] : []
        content {
          operator         = try(request_uri_condition.value.operator, null)
          negate_condition = try(request_uri_condition.value.negate_condition, null)
          match_values     = try(request_uri_condition.value.match_values, null)
          transforms       = try(request_uri_condition.value.transforms, null)
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = try(var.settings.url_file_extension_condition, null) != null ? [var.settings.url_file_extension_condition] : []
        content {
          operator         = try(url_file_extension_condition.value.operator, null)
          negate_condition = try(url_file_extension_condition.value.negate_condition, null)
          match_values     = try(url_file_extension_condition.value.match_values, null)
          transforms       = try(url_file_extension_condition.value.transforms, null)
        }
      }
      dynamic "url_file_name_condition" {
        for_each = try(var.settings.url_file_name_condition, null) != null ? [var.settings.url_file_name_condition] : []
        content {
          operator         = try(url_file_name_condition.value.operator, null)
          negate_condition = try(url_file_name_condition.value.negate_condition, null)
          match_values     = try(url_file_name_condition.value.match_values, null)
          transforms       = try(url_file_name_condition.value.transforms, null)
        }
      }
      dynamic "url_path_condition" {
        for_each = try(var.settings.url_path_condition, null) != null ? [var.settings.url_path_condition] : []
        content {
          operator         = try(url_path_condition.value.operator, null)
          negate_condition = try(url_path_condition.value.negate_condition, null)
          match_values     = try(url_path_condition.value.match_values, null)
          transforms       = try(url_path_condition.value.transforms, null)
        }
      }
      dynamic "url_redirect_action" {
        for_each = try(var.settings.url_redirect_action, null) != null ? [var.settings.url_redirect_action] : []
        content {
          redirect_type = try(url_redirect_action.value.redirect_type, null)
          protocol      = try(url_redirect_action.value.protocol, null)
          hostname      = try(url_redirect_action.value.hostname, null)
          path          = try(url_redirect_action.value.path, null)
          fragment      = try(url_redirect_action.value.fragment, null)
          query_string  = try(url_redirect_action.value.query_string, null)
        }
      }
      dynamic "url_rewrite_action" {
        for_each = try(var.settings.url_rewrite_action, null) != null ? [var.settings.url_rewrite_action] : []
        content {
          source_pattern          = try(url_rewrite_action.value.source_pattern, null)
          destination             = try(url_rewrite_action.value.destination, null)
          preserve_unmatched_path = try(url_rewrite_action.value.preserve_unmatched_path, null)
        }
      }
    }
  }
  tags = local.tags
}
