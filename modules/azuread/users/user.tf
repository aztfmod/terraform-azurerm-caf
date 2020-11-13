
resource "azurecaf_name" "account" {
  name          = local.user_name
  resource_type = "azurerm_resource_group"
  #TODO: need to be changed to appropriate resource (no caf reference for now)
  prefixes      = [local.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

#
#
resource "azuread_user" "account" {
  user_principal_name = format("%s@%s", azurecaf_name.account.result, local.tenant_name)
  display_name        = azurecaf_name.account.result
  password            = random_password.account.result

  lifecycle {
    ignore_changes = [user_principal_name]
  }
}


resource "random_password" "account" {
  length  = 250
  special = false
  upper   = true
  number  = true
}


resource "azurerm_key_vault_secret" "aad_user_name" {
  name         = format("%s%s-name", local.secret_prefix, local.user_name)
  value        = azuread_user.account.user_principal_name
  key_vault_id = local.keyvault_id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  name            = format("%s%s-password", local.secret_prefix, local.user_name)
  value           = random_password.account.result
  expiration_date = timeadd(timestamp(), format("%sh", local.password_expire_in_days * 24))
  key_vault_id    = local.keyvault_id

  lifecycle {
    ignore_changes = [
      expiration_date, value
    ]
  }
}