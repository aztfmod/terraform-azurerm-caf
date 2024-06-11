resource "azurerm_cdn_frontdoor_rule" "this" {
  name                      = var.settings.name
  cdn_frontdoor_rule_set_id = var.cdn_frontdoor_rule_set_id
  order                     = var.settings.order
  behavior_on_match         = try(var.settings.behavior_on_match, null)

  actions {
    dynamic "route_configuration_override_action" {
      for_each = try(var.settings.actions.route_configuration_override_actions, null) == null ? [] : [var.settings.actions.route_configuration_override_actions]
      content {
        cdn_frontdoor_origin_group_id = try(var.cdn_frontdoor_origin_groups[route_configuration_override_action.value.cdn_frontdoor_origin_group_key].id, null)
        forwarding_protocol           = try(route_configuration_override_action.value.forwarding_protocol, null)
        query_string_caching_behavior = try(route_configuration_override_action.value.query_string_caching_behavior, null)
        query_string_parameters       = try(route_configuration_override_action.value.query_string_parameters, [])
        compression_enabled           = try(route_configuration_override_action.value.compression_enabled, false)
        cache_behavior                = try(route_configuration_override_action.value.cache_behavior, null)
        cache_duration                = try(route_configuration_override_action.value.cache_duration, null)
      }
    }
    dynamic "url_redirect_action" {
      for_each = try(var.settings.actions.url_redirect_actions, {})
      content {
        redirect_type        = try(url_redirect_action.value.redirect_type, null)
        redirect_protocol    = try(url_redirect_action.value.redirect_protocol, null)
        query_string         = try(url_redirect_action.value.query_string, null)
        destination_path     = try(url_redirect_action.value.destination_path, null)
        destination_hostname = try(url_redirect_action.value.destination_hostname, null)
        destination_fragment = try(url_redirect_action.value.destination_fragment, null)
      }
    }
    dynamic "url_rewrite_action" {
      for_each = try(var.settings.actions.url_rewrite_action, {})
      content {
        source_pattern          = url_rewrite_action.value.source_pattern
        destination             = url_rewrite_action.value.destination
        preserve_unmatched_path = try(url_rewrite_action.value.preserve_unmatched_path, null)
      }
    }
    dynamic "request_header_action" {
      for_each = try(var.settings.actions.request_header_action, {})
      content {
        header_action = request_header_action.value.header_action
        header_name   = request_header_action.value.header_name
        value         = try(request_header_action.value.value, null)
      }
    }
    dynamic "response_header_action" {
      for_each = try(var.settings.actions.response_header_action, {})
      content {
        header_action = response_header_action.value.header_action
        header_name   = response_header_action.value.header_name
        value         = try(response_header_action.value.value, null)
      }
    }
  }
  dynamic "conditions" {
    for_each = try(var.settings.conditions, null) == null ? [] : [var.settings.conditions]
    content {
      dynamic "host_name_condition" {
        for_each = try(conditions.value.host_name_condition, {})
        content {
          operator         = host_name_condition.value.operator
          negate_condition = try(host_name_condition.value.negate_condition, null)
          match_values     = try(host_name_condition.value.match_values, [])
          transforms       = try(host_name_condition.value.transforms, null)
        }
      }
      dynamic "is_device_condition" {
        for_each = try(conditions.value.is_device_condition, {})
        content {
          operator         = is_device_condition.value.operator
          negate_condition = try(is_device_condition.value.negate_condition, false)
          match_values     = try(is_device_condition.value.match_values, [])
        }
      }
      dynamic "post_args_condition" {
        for_each = try(conditions.value.post_args_condition, {})
        content {
          post_args_name   = post_args_condition.value.post_args_name
          operator         = try(post_args_condition.value.operator, null)
          match_values     = try(post_args_condition.value.match_values, [])
          negate_condition = try(post_args_condition.value.negate_condition, null)
          transforms       = try(post_args_condition.value.transforms, null)
        }
      }
      dynamic "remote_address_condition" {
        for_each = try(var.settings.conditions.remote_address_condition, {})
        content {
          operator         = try(remote_address_condition.value.operator, null)
          negate_condition = try(remote_address_condition.value.negate_condition, false)
          match_values     = try(remote_address_condition.value.match_values, [])
        }
      }
      dynamic "request_method_condition" {
        for_each = try(var.settings.conditions.request_method_condition, {})
        content {
          operator         = try(request_method_condition.value.operator, null)
          negate_condition = try(request_method_condition.value.negate_condition, false)
          match_values     = try(request_method_condition.value.match_values, [])
        }
      }
      dynamic "query_string_condition" {
        for_each = try(var.settings.conditions.query_string_condition, {})
        content {
          operator         = try(query_string_condition.value.operator, null)
          negate_condition = try(query_string_condition.value.negate_condition, false)
          match_values     = try(query_string_condition.value.match_values, [])
          transforms       = try(query_string_condition.value.transforms, null)
        }
      }
      dynamic "request_uri_condition" {
        for_each = try(var.settings.conditions.request_uri_condition, {})
        content {
          operator         = try(request_uri_condition.value.operator, null)
          negate_condition = try(request_uri_condition.value.negate_condition, false)
          match_values     = try(request_uri_condition.value.match_values, [])
          transforms       = try(request_uri_condition.value.transforms, null)
        }
      }
      dynamic "request_header_condition" {
        for_each = try(var.settings.conditions.request_header_condition, {})
        content {
          header_name      = request_header_condition.value.header_name
          operator         = try(request_header_condition.value.operator, null)
          negate_condition = try(request_header_condition.value.negate_condition, false)
          match_values     = try(request_header_condition.value.match_values, [])
          transforms       = try(request_header_condition.value.transforms, null)
        }
      }
      dynamic "request_body_condition" {
        for_each = try(var.settings.conditions.request_body_condition, {})
        content {
          operator         = try(request_body_condition.value.operator, null)
          negate_condition = try(request_body_condition.value.negate_condition, false)
          match_values     = try(request_body_condition.value.match_values, [])
          transforms       = try(request_body_condition.value.transforms, null)
        }
      }
      dynamic "request_scheme_condition" {
        for_each = try(var.settings.conditions.request_scheme_condition, {})
        content {
          operator         = try(request_scheme_condition.value.operator, null)
          negate_condition = try(request_scheme_condition.value.negate_condition, false)
          match_values     = try(request_scheme_condition.value.match_values, [])
        }
      }
      dynamic "url_path_condition" {
        for_each = try(var.settings.conditions.url_path_condition, {})
        content {
          operator         = try(url_path_condition.value.operator, null)
          negate_condition = try(url_path_condition.value.negate_condition, false)
          match_values     = try(url_path_condition.value.match_values, [])
          transforms       = try(url_path_condition.value.transforms, null)
        }
      }
      dynamic "url_file_extension_condition" {
        for_each = try(var.settings.conditions.url_file_extension_condition, {})
        content {
          operator         = try(url_file_extension_condition.value.operator, null)
          negate_condition = try(url_file_extension_condition.value.negate_condition, false)
          match_values     = try(url_file_extension_condition.value.match_values, [])
          transforms       = try(url_file_extension_condition.value.transforms, null)
        }
      }
      dynamic "url_filename_condition" {
        for_each = try(var.settings.conditions.url_filename_condition, {})
        content {
          operator         = try(url_filename_condition.value.operator, null)
          negate_condition = try(url_filename_condition.value.negate_condition, false)
          match_values     = try(url_filename_condition.value.match_values, [])
          transforms       = try(url_filename_condition.value.transforms, null)
        }
      }
      dynamic "http_version_condition" {
        for_each = try(var.settings.conditions.http_version_condition, {})
        content {
          operator         = try(http_version_condition.value.operator, null)
          negate_condition = try(http_version_condition.value.negate_condition, false)
          match_values     = try(http_version_condition.value.match_values, [])
        }
      }
      dynamic "cookies_condition" {
        for_each = try(var.settings.conditions.cookies_condition, {})
        content {
          cookie_name      = cookies_condition.value.cookie_name
          operator         = try(cookies_condition.value.operator, null)
          negate_condition = try(cookies_condition.value.negate_condition, false)
          match_values     = try(cookies_condition.value.match_values, [])
          transforms       = try(cookies_condition.value.transforms, null)
        }
      }
      dynamic "is_device_condition" {
        for_each = try(var.settings.conditions.is_device_condition, {})
        content {
          operator         = try(is_device_condition.value.operator, null)
          negate_condition = try(is_device_condition.value.negate_condition, false)
          match_values     = try(is_device_condition.value.match_values, [])
        }
      }
      dynamic "socket_address_condition" {
        for_each = try(var.settings.conditions.socket_address_condition, {})
        content {
          operator         = try(socket_address_condition.value.operator, null)
          negate_condition = try(socket_address_condition.value.negate_condition, false)
          match_values     = try(socket_address_condition.value.match_values, [])
        }
      }
      dynamic "client_port_condition" {
        for_each = try(var.settings.conditions.client_port_condition, {})
        content {
          operator         = try(client_port_condition.value.operator, null)
          negate_condition = try(client_port_condition.value.negate_condition, false)
          match_values     = try(client_port_condition.value.match_values, [])
        }
      }
      dynamic "server_port_condition" {
        for_each = try(var.settings.conditions.server_port_condition, {})
        content {
          operator         = try(server_port_condition.value.operator, null)
          negate_condition = try(server_port_condition.value.negate_condition, false)
          match_values     = try(server_port_condition.value.match_values, [])
        }
      }
      dynamic "ssl_protocol_condition" {
        for_each = try(var.settings.conditions.ssl_protocol_condition, {})
        content {
          operator         = try(ssl_protocol_condition.value.operator, null)
          negate_condition = try(ssl_protocol_condition.value.negate_condition, false)
          match_values     = try(ssl_protocol_condition.value.match_values, [])
        }
      }
    }
  }
}