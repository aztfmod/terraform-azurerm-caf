locals {
  global_settings = {
    prefixes      = lookup(var.settings, "useprefix", null) == true ? try(var.settings.global_settings.prefixes, var.global_settings.prefixes) : []
    random_length = try(var.settings.global_settings.random_length, var.global_settings.random_length)
    passthrough   = try(var.settings.global_settings.passthrough, var.global_settings.passthrough)
    use_slug      = try(var.settings.global_settings.use_slug, var.global_settings.use_slug)
  }

  password_policy = try(var.settings.password_policy, var.password_policy)
  user_name       = var.settings.user_name
  tenant_name     = lookup(var.settings, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  keyvault_id     = var.keyvaults[var.client_config.landingzone_key][var.settings.keyvault_key].id
  secret_prefix   = lookup(var.settings, "secret_prefix", "")
}

resource "azurecaf_name" "account" {
  name          = local.user_name
  resource_type = "azurerm_resource_group"
  #TODO: need to be changed to appropriate resource (no caf reference for now)
  prefixes      = local.global_settings.prefixes
  random_length = local.global_settings.random_length
  clean_input   = true
  passthrough   = local.global_settings.passthrough
  use_slug      = local.global_settings.use_slug
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
  rotation_minutes = try(local.password_policy.rotation.mins, null)
  rotation_days    = try(local.password_policy.rotation.days, null)
  rotation_months  = try(local.password_policy.rotation.months, null)
  rotation_years   = try(local.password_policy.rotation.years, null)
}

# Will force the password to change every month
resource "random_password" "pwd" {
  keepers = {
    frequency = time_rotating.pwd.id
  }
  length  = local.password_policy.length
  special = local.password_policy.special
  upper   = local.password_policy.upper
  numeric = local.password_policy.number
}


resource "azurerm_key_vault_secret" "aad_user_name" {
  name         = format("%s%s-name", local.secret_prefix, local.user_name)
  value        = azuread_user.account.user_principal_name
  key_vault_id = local.keyvault_id
}

resource "azurerm_key_vault_secret" "aad_user_password" {
  name            = format("%s%s-password", local.secret_prefix, local.user_name)
  value           = random_password.pwd.result
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
  key_vault_id    = local.keyvault_id
}