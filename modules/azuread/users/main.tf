terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

data "azuread_client_config" "current" {}

locals {
  user_name               = var.azuread_users.user_name
  tenant_name             = lookup(var.azuread_users, "tenant_name", data.azuread_client_config.current.tenant_id)
  keyvault_id             = var.keyvaults[var.azuread_users.keyvault_key].id
  secret_prefix           = lookup(var.azuread_users, "secret_prefix", "")
  password_expire_in_days = lookup(var.azuread_users, "password_expire_in_days", 180)

  # Global settings can be overwritten
  prefix     = lookup(var.azuread_users, "useprefix", null) == true ? var.global_settings.prefix : ""
  convention = lookup(var.azuread_users, "convention", var.global_settings.convention)
  max_length = lookup(var.azuread_users, "max_length", var.global_settings.max_length)
}