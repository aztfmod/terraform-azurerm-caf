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
  user_name               = var.azuread_user.user_name
  tenant_name             = lookup(var.azuread_user, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  keyvault_id             = var.keyvaults[var.client_config.landingzone_key][var.azuread_user.keyvault_key].id
  secret_prefix           = lookup(var.azuread_user, "secret_prefix", "")

  # Global settings can be overwritten
  prefix = lookup(var.azuread_user, "useprefix", null) == true ? [var.global_settings.prefix] : []

}