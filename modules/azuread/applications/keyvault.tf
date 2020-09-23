module keyvault_secret_policy {
  # count = try(var.keyvaults[var.settings.keyvault.keyvault_key].id, null) != null ? 1 : 0
  for_each = {
    for key, value in var.settings.keyvault : key => value
    if try(value.keyvault_key, null) != null
  }

  source                  = "./keyvault"
  settings                = var.settings.keyvault
  keyvault_id             = var.keyvaults[var.settings.keyvault.keyvault_key].id
  password_expire_in_days = try(var.settings.password_expire_in_days, 180)

  # Used by the az cli client id and ARM_CLIENT_ID
  application_id = azuread_application.app.application_id
  object_id      = azuread_service_principal.app.object_id
  client_secret  = azuread_service_principal_password.app.value
  tenant_id      = var.client_config.tenant_id
  tfstates       = var.tfstates
  use_msi        = var.use_msi
}

