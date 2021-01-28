
resource "azurecaf_name" "account" {
  name          = local.user_name
  resource_type = "azurerm_resource_group"
  #TODO: need to be changed to appropriate resource (no caf reference for now)
  prefixes      = local.prefix
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
  password            = random_password.pwd.result

  lifecycle {
    ignore_changes = [user_principal_name]
  }
}


resource "time_rotating" "pwd" {
  rotation_minutes = try(var.settings.password_policy.rotation.mins, lookup(var.password_policy.rotation, "mins", null))
  rotation_days    = try(var.settings.password_policy.rotation.days, lookup(var.password_policy.rotation, "days", null))
  rotation_months  = try(var.settings.password_policy.rotation.months, lookup(var.password_policy.rotation, "months", null))
  rotation_years   = try(var.settings.password_policy.rotation.years, lookup(var.password_policy.rotation, "years", null))
}

# Will force the password to change every month
resource "random_password" "pwd" {
  keepers = {
    frequency = time_rotating.pwd.id
  }
  length  = try(var.settings.password_policy.length, var.password_policy.length)
  special = try(var.settings.password_policy.special, var.password_policy.special)
  upper   = try(var.settings.password_policy.upper, var.password_policy.upper)
  number  = try(var.settings.password_policy.number, var.password_policy.number)
}


resource "azurerm_key_vault_secret" "aad_user_name" {
  name         = format("%s%s-name", local.secret_prefix, local.user_name)
  value        = azuread_user.account.user_principal_name
  key_vault_id = local.keyvault_id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  name            = format("%s%s-password", local.secret_prefix, local.user_name)
  value           = random_password.pwd.result
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", try(var.settings.password_policy.expire_in_days, var.password_policy.expire_in_days) * 24))
  key_vault_id    = local.keyvault_id
}