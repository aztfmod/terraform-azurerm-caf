resource "azurerm_container_app_environment_dapr_component" "cadc" {
  name                         = var.settings.name
  container_app_environment_id = var.container_app_environment_id
  component_type               = var.settings.component_type
  version                      = var.settings.version
  ignore_errors                = try(var.settings.ignore_errors, false)
  init_timeout                 = try(var.settings.init_timeout, null)
  scopes                       = try(var.settings.scopes, null)

  dynamic "metadata" {
    for_each = try(var.settings.metadata, {})

    content {
      name        = metadata.value.name
      secret_name = try(metadata.value.secret_name, null)
      value       = try(metadata.value.value, null)
    }
  }

  dynamic "secret" {
    for_each = try(var.settings.secret, {})

    content {
      name  = secret.value.name
      value = secret.value.value
    }
  }
}
