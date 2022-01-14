resource "azurerm_api_management_api_operation" "apim" {
  operation_id        = var.settings.operation_id
  api_name            = var.api_name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name
  display_name        = var.settings.display_name
  method              = var.settings.method
  url_template        = var.settings.url_template
  description         = try(var.settings.description, null)
  dynamic "request" {
    for_each = try(var.settings.request, null) != null ? [var.settings.request] : []
    content {
      description = try(request.value.description, null)
      dynamic "header" {
        for_each = try(var.settings.header, null) != null ? [var.settings.header] : []
        content {
          name          = try(header.value.name, null)
          required      = try(header.value.required, null)
          type          = try(header.value.type, null)
          description   = try(header.value.description, null)
          default_value = try(header.value.default_value, null)
          values        = try(header.value.values, null)
        }
      }
      dynamic "query_parameter" {
        for_each = try(var.settings.query_parameter, null) != null ? [var.settings.query_parameter] : []
        content {
          name          = try(query_parameter.value.name, null)
          required      = try(query_parameter.value.required, null)
          type          = try(query_parameter.value.type, null)
          description   = try(query_parameter.value.description, null)
          default_value = try(query_parameter.value.default_value, null)
          values        = try(query_parameter.value.values, null)
        }
      }
      dynamic "representation" {
        for_each = try(var.settings.representation, null) != null ? [var.settings.representation] : []
        content {
          content_type = try(representation.value.content_type, null)
          dynamic "form_parameter" {
            for_each = try(var.settings.form_parameter, null) != null ? [var.settings.form_parameter] : []
            content {
              name          = try(form_parameter.value.name, null)
              required      = try(form_parameter.value.required, null)
              type          = try(form_parameter.value.type, null)
              description   = try(form_parameter.value.description, null)
              default_value = try(form_parameter.value.default_value, null)
              values        = try(form_parameter.value.values, null)
            }
          }
          # dynamic "example" {
          #   for_each = try(var.settings.example, null) != null ? [var.settings.example] : []
          #   content {
          #     name           = try(example.value.name, null)
          #     summary        = try(example.value.summary, null)
          #     description    = try(example.value.description, null)
          #     value          = try(example.value.value, null)
          #     external_value = try(example.value.external_value, null)
          #   }
          # }
          sample    = try(representation.value.sample, null)
          schema_id = try(representation.value.schema_id, null)
          type_name = try(representation.value.type_name, null)
        }
      }
    }
  }
  dynamic "response" {
    for_each = try(var.settings.response, null) != null ? [var.settings.response] : []
    content {
      status_code = try(response.value.status_code, null)
      description = try(response.value.description, null)
      dynamic "header" {
        for_each = try(var.settings.header, null) != null ? [var.settings.header] : []
        content {
          name          = try(header.value.name, null)
          required      = try(header.value.required, null)
          type          = try(header.value.type, null)
          description   = try(header.value.description, null)
          default_value = try(header.value.default_value, null)
          values        = try(header.value.values, null)
        }
      }
      dynamic "representation" {
        for_each = try(var.settings.representation, null) != null ? [var.settings.representation] : []
        content {
          content_type = try(representation.value.content_type, null)
          dynamic "form_parameter" {
            for_each = try(var.settings.form_parameter, null) != null ? [var.settings.form_parameter] : []
            content {
              name          = try(form_parameter.value.name, null)
              required      = try(form_parameter.value.required, null)
              type          = try(form_parameter.value.type, null)
              description   = try(form_parameter.value.description, null)
              default_value = try(form_parameter.value.default_value, null)
              values        = try(form_parameter.value.values, null)
            }
          }
          # dynamic "example" {
          #   for_each = try(var.settings.example, null) != null ? [var.settings.example] : []
          #   content {
          #     name           = try(example.value.name, null)
          #     summary        = try(example.value.summary, null)
          #     description    = try(example.value.description, null)
          #     value          = try(example.value.value, null)
          #     external_value = try(example.value.external_value, null)
          #   }
          # }
          sample    = try(representation.value.sample, null)
          schema_id = try(representation.value.schema_id, null)
          type_name = try(representation.value.type_name, null)
        }
      }
    }
  }
  dynamic "template_parameter" {
    for_each = try(var.settings.template_parameter, null) != null ? [var.settings.template_parameter] : []
    content {
      name          = try(template_parameter.value.name, null)
      required      = try(template_parameter.value.required, null)
      type          = try(template_parameter.value.type, null)
      description   = try(template_parameter.value.description, null)
      default_value = try(template_parameter.value.default_value, null)
      values        = try(template_parameter.value.values, null)
    }
  }
}