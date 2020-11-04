terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}

data "azuread_domains" "aad_domains" {
  only_initial = true
}

locals {
  user_name               = var.azuread_users.user_name
  tenant_name             = lookup(var.azuread_users, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  keyvault_id             = var.keyvaults[var.client_config.landingzone_key][var.azuread_users.keyvault_key].id
  secret_prefix           = lookup(var.azuread_users, "secret_prefix", "")
  password_expire_in_days = lookup(var.azuread_users, "password_expire_in_days", 180)

  # Global settings can be overwritten
  prefix = lookup(var.azuread_users, "useprefix", null) == true ? var.global_settings.prefix : ""

}