output "tenant_id" {
  value = var.client_config.tenant_id
}

output "service_principal_id" {
  value       = azuread_service_principal_password.pwd.service_principal_id
  description = "The object ID of the service principal for which this password should be created"
}
output "display_name" {
  value       = azuread_service_principal_password.pwd.display_name
  description = "A display name for the password"
}
output "start_date" {
  value       = azuread_service_principal_password.pwd.start_date
  description = "The start date from which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`). If this isn't specified, the current date is used"
}
output "end_date" {
  value       = azuread_service_principal_password.pwd.end_date
  description = "The end date until which the password is valid, formatted as an RFC3339 date string (e.g. `2018-01-01T01:02:03Z`)"
}
output "end_date_relative" {
  value       = azuread_service_principal_password.pwd.end_date_relative
  description = "A relative duration for which the password is valid until, for example `240h` (10 days) or `2400h30m`. Changing this field forces a new resource to be created"
}
output "key_id" {
  value       = azuread_service_principal_password.pwd.key_id
  description = "A UUID used to uniquely identify this password credential"
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