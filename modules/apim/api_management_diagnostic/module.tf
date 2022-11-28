resource "azurerm_api_management_diagnostic" "apim" {
  identifier               = var.settings.identifier
  api_management_name      = var.api_management_name
  resource_group_name      = var.resource_group_name
  api_management_logger_id = var.api_management_logger_id
  always_log_errors        = try(var.settings.always_log_errors, null)
  dynamic "backend_request" {
    for_each = try(var.settings.backend_request, null) != null ? [var.settings.backend_request] : []
    content {
      body_bytes     = try(backend_request.value.body_bytes, null)
      headers_to_log = try(backend_request.value.headers_to_log, null)
    }
  }

  dynamic "backend_response" {
    for_each = try(var.settings.backend_response, null) != null ? [var.settings.backend_response] : []
    content {
      body_bytes     = try(backend_response.value.body_bytes, null)
      headers_to_log = try(backend_response.value.headers_to_log, null)
    }
  }

  dynamic "frontend_request" {
    for_each = try(var.settings.frontend_request, null) != null ? [var.settings.frontend_request] : []
    content {
      body_bytes     = try(frontend_request.value.body_bytes, null)
      headers_to_log = try(frontend_request.value.headers_to_log, null)
    }
  }

  dynamic "frontend_response" {
    for_each = try(var.settings.frontend_response, null) != null ? [var.settings.frontend_response] : []
    content {

      body_bytes = try(frontend_response.value.body_bytes, null)

      headers_to_log = try(frontend_response.value.headers_to_log, null)

    }
  }
  http_correlation_protocol = try(var.settings.http_correlation_protocol, null)
  log_client_ip             = try(var.settings.log_client_ip, null)
  sampling_percentage       = try(var.settings.sampling_percentage, null)
  verbosity                 = try(var.settings.verbosity, null)
  operation_name_format     = try(var.settings.operation_name_format, null)
}