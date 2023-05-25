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
        for_each = try(request.value.headers, {})
        content {
          name          = header.value.name
          required      = header.value.required
          type          = header.value.type
          description   = try(header.value.description, null)
          default_value = try(header.value.default_value, null)
          values        = try(header.value.values, null)
          schema_id     = try(header.value.schema_id, null)
          type_name     = try(header.value.type_name, null)

          dynamic "example" {
            for_each = try(header.value.examples, {})
            content {
              name           = example.value.name
              summary        = try(example.value.summary, null)
              description    = try(example.value.description, null)
              value          = try(example.value.value, null)
              external_value = try(example.value.external_value, null)
            }
          }
        }
      }
      dynamic "query_parameter" {
        for_each = try(request.value.query_parameters, {})
        content {
          name          = query_parameter.value.name
          required      = query_parameter.value.required
          type          = query_parameter.value.type
          description   = try(query_parameter.value.description, null)
          default_value = try(query_parameter.value.default_value, null)
          values        = try(query_parameter.value.values, null)
          schema_id     = try(query_parameter.value.schema_id, null)
          type_name     = try(query_parameter.value.type_name, null)

          dynamic "example" {
            for_each = try(query_parameter.value.examples, {})
            content {
              name           = example.value.name
              summary        = try(example.value.summary, null)
              description    = try(example.value.description, null)
              value          = try(example.value.value, null)
              external_value = try(example.value.external_value, null)
            }
          }
        }
      }
      dynamic "representation" {
        for_each = try(request.value.representations, {})
        content {
          content_type = representation.value.content_type
          dynamic "form_parameter" {
            for_each = try(representation.value.form_parameters, {})
            content {
              name          = form_parameter.value.name
              required      = form_parameter.value.required
              type          = form_parameter.value.type
              description   = try(form_parameter.value.description, null)
              default_value = try(form_parameter.value.default_value, null)
              values        = try(form_parameter.value.values, null)
              schema_id     = try(form_parameter.value.schema_id, null)
              type_name     = try(form_parameter.value.type_name, null)

              dynamic "example" {
                for_each = try(form_parameter.value.examples, {})
                content {
                  name           = example.value.name
                  summary        = try(example.value.summary, null)
                  description    = try(example.value.description, null)
                  value          = try(example.value.value, null)
                  external_value = try(example.value.external_value, null)
                }
              }
            }
          }
          dynamic "example" {
            for_each = try(representation.value.examples, {})
            content {
              name           = try(example.value.name, null)
              summary        = try(example.value.summary, null)
              description    = try(example.value.description, null)
              value          = try(example.value.value, null)
              external_value = try(example.value.external_value, null)
            }
          }
          schema_id = try(representation.value.schema_id, null)
          type_name = try(representation.value.type_name, null)
        }
      }
    }
  }
  dynamic "response" {
    for_each = try(var.settings.responses, {})
    content {
      status_code = response.value.status_code
      description = try(response.value.description, null)
      dynamic "header" {
        for_each = try(response.value.headers, {})
        content {
          name          = header.value.name
          required      = header.value.required
          type          = header.value.type
          description   = try(header.value.description, null)
          default_value = try(header.value.default_value, null)
          values        = try(header.value.values, null)
          schema_id     = try(header.value.schema_id, null)
          type_name     = try(header.value.type_name, null)

          dynamic "example" {
            for_each = try(header.value.examples, {})
            content {
              name           = example.value.name
              summary        = try(example.value.summary, null)
              description    = try(example.value.description, null)
              value          = try(example.value.value, null)
              external_value = try(example.value.external_value, null)
            }
          }
        }
      }
      dynamic "representation" {
        for_each = try(response.value.representations, {})
        content {
          content_type = representation.value.content_type
          dynamic "form_parameter" {
            for_each = try(representation.value.form_parameters, {})
            content {
              name          = form_parameter.value.name
              required      = form_parameter.value.required
              type          = form_parameter.value.type
              description   = try(form_parameter.value.description, null)
              default_value = try(form_parameter.value.default_value, null)
              values        = try(form_parameter.value.values, null)
              schema_id     = try(form_parameter.value.schema_id, null)
              type_name     = try(form_parameter.value.type_name, null)

              dynamic "example" {
                for_each = try(form_parameter.value.examples, {})
                content {
                  name           = example.value.name
                  summary        = try(example.value.summary, null)
                  description    = try(example.value.description, null)
                  value          = try(example.value.value, null)
                  external_value = try(example.value.external_value, null)
                }
              }
            }
          }
          dynamic "example" {
            for_each = try(representation.value.examples, {})
            content {
              name           = try(example.value.name, null)
              summary        = try(example.value.summary, null)
              description    = try(example.value.description, null)
              value          = try(example.value.value, null)
              external_value = try(example.value.external_value, null)
            }
          }
          schema_id = try(representation.value.schema_id, null)
          type_name = try(representation.value.type_name, null)
        }
      }
    }
  }
  dynamic "template_parameter" {
    for_each = try(var.settings.template_parameters, {})
    content {
      name          = template_parameter.value.name
      required      = template_parameter.value.required
      type          = template_parameter.value.type
      description   = try(template_parameter.value.description, null)
      default_value = try(template_parameter.value.default_value, null)
      values        = try(template_parameter.value.values, null)
      schema_id     = try(template_parameter.value.schema_id, null)
      type_name     = try(template_parameter.value.type_name, null)

      dynamic "example" {
        for_each = try(template_parameter.value.examples, {})
        content {
          name           = example.value.name
          summary        = try(example.value.summary, null)
          description    = try(example.value.description, null)
          value          = try(example.value.value, null)
          external_value = try(example.value.external_value, null)
        }
      }
    }
  }

  lifecycle {
    precondition {
      condition     = contains(["GET", "DELETE", "PUT", "POST"], var.settings.method)
      error_message = format("Enter a valid value for method: GET, DELETE, PUT, POST. Got: %s", var.settings.method)
    }
  }

}