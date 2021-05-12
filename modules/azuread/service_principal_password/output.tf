
output "tenant_id" {
  value = var.client_config.tenant_id
}
output "key_id" {
  value = azuread_service_principal_password.pwd.key_id
}
output "service_principal_id" {
  value = azuread_service_principal_password.pwd.service_principal_id
}
output "end_date" {
  value = azuread_service_principal_password.pwd.end_date
}
output "end_date_relative" {
  value = azuread_service_principal_password.pwd.end_date_relative
}
output "start_date" {
  value = azuread_service_principal_password.pwd.start_date
}
output "keyvaults" {
  value = {
    for key, value in try(var.settings.keyvaults, {}) : key => {
      id                        = azurerm_key_vault_secret.client_id[key].key_vault_id
      secret_name_client_secret = value.secret_prefix
    }
  }
  description = "Keyvaults storing the passwords. Store the secret_prefix-client-id, secret_prefix-client-secret"
}