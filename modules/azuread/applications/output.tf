
output "tenant_id" {
  value = var.client_config.tenant_id

}

output "azuread_application" {
  value = {
    id             = azuread_application.app.id
    object_id      = azuread_application.app.object_id
    application_id = azuread_application.app.application_id
    name           = azuread_application.app.name
  }

}

output "azuread_service_principal" {
  value = {
    id        = azuread_service_principal.app.id
    object_id = azuread_service_principal.app.object_id
  }

}

output "keyvaults" {
  value = {
    for key, value in try(var.settings.keyvaults, {}) : key => {
      id                        = azurerm_key_vault_secret.client_id[key].key_vault_id
      secret_name_client_secret = value.secret_prefix
    }
  }
}

output "rbac_id" {
  value       = azuread_service_principal.app.object_id
  description = "This attribute is used to set the role assignment"
}