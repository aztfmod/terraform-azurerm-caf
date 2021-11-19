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
  name = azurecaf_name.cdn.result
  
  resource_group_name = var.resource_group_name  
  profile_name = var.settings.profile_name  
  location = var.location  
  is_http_allowed = try(var.settings.is_http_allowed,null)  
  is_https_allowed = try(var.settings.is_https_allowed,null)  
  content_types_to_compress = try(var.settings.content_types_to_compress,null)  
  geo_filter = try(var.settings.geo_filter,null)  
  is_compression_enabled = try(var.settings.is_compression_enabled,null)  
  querystring_caching_behaviour = try(var.settings.querystring_caching_behaviour,null)  
  optimization_type = try(var.settings.optimization_type,null)  

  dynamic "origin" {
    for_each = try(var.settings.origin, null) != null ? [var.settings.origin] : []

    content {
      name = origin.value.name
      host_name = origin.value.host_name
      http_port = origin.value.http_port
      https_port = origin.value.https_port
      relative_path = origin.value.relative_path
      action = origin.value.action
      country_codes = origin.value.country_codes
    }
  }
  
  origin_host_header = try(var.settings.origin_host_header,null)  
  origin_path = try(var.settings.origin_path,null)  
  probe_path = try(var.settings.probe_path,null)  

  dynamic "global_delivery_rule" {
    for_each = try(var.settings.global_delivery_rule, null) != null ? [var.settings.global_delivery_rule] : []

    content {
      cache_expiration_action = global_delivery_rule.value.cache_expiration_action
      cache_key_query_string_action = global_delivery_rule.value.cache_key_query_string_action
      modify_request_header_action = global_delivery_rule.value.modify_request_header_action
      modify_response_header_action = global_delivery_rule.value.modify_response_header_action
      url_redirect_action = global_delivery_rule.value.url_redirect_action
      url_rewrite_action = global_delivery_rule.value.url_rewrite_action
    }
  }
  

  dynamic "delivery_rule" {
    for_each = try(var.settings.delivery_rule, null) != null ? [var.settings.delivery_rule] : []

    content {
      name = delivery_rule.value.name
      order = delivery_rule.value.order
      cache_expiration_action = delivery_rule.value.cache_expiration_action
      cache_key_query_string_action = delivery_rule.value.cache_key_query_string_action
      cookies_condition = delivery_rule.value.cookies_condition
      device_condition = delivery_rule.value.device_condition
      http_version_condition = delivery_rule.value.http_version_condition
      modify_request_header_action = delivery_rule.value.modify_request_header_action
      modify_response_header_action = delivery_rule.value.modify_response_header_action
      post_arg_condition = delivery_rule.value.post_arg_condition
      query_string_condition = delivery_rule.value.query_string_condition
      remote_address_condition = delivery_rule.value.remote_address_condition
      request_body_condition = delivery_rule.value.request_body_condition
      request_header_condition = delivery_rule.value.request_header_condition
      request_method_condition = delivery_rule.value.request_method_condition
      request_scheme_condition = delivery_rule.value.request_scheme_condition
      request_uri_condition = delivery_rule.value.request_uri_condition
      url_file_extension_condition = delivery_rule.value.url_file_extension_condition
      url_file_name_condition = delivery_rule.value.url_file_name_condition
      url_path_condition = delivery_rule.value.url_path_condition
      url_redirect_action = delivery_rule.value.url_redirect_action
      url_rewrite_action = delivery_rule.value.url_rewrite_action
    }
  }
  
  tags = local.tags
  
}
