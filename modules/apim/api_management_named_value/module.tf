resource "azurerm_api_management_named_value" "apim" {
  name                  = var.settings.name
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  display_name          = var.settings.display_name
  value                 = try(var.settings.value, null)
  secret                = try(var.settings.secret, null)

  dynamic "value_from_key_vault" {
    for_each = try(var.settings.value_from_key_vault, null) != null ? [var.settings.value_from_key_vault] : []
    content {
      secret_id                    = try(management.value.secret_id, null)
      identity_client_id           = try(scm.value.identity_client_id, null)
    }
  }
}
