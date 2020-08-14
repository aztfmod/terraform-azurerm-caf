
resource "azurecaf_naming_convention" "account" {
  name          = local.user_name
  prefix        = local.prefix
  resource_type = "rg" # workaround to keep the dashes
  convention    = local.convention
  max_length    = local.max_length
}

# 
#
resource "azuread_user" "account" {
  user_principal_name = format("%s@%s", azurecaf_naming_convention.account.result, local.tenant_name)
  display_name        = azurecaf_naming_convention.account.result
  password            = random_password.account.result
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
}