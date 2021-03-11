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
  user_name     = var.settings.user_name
  tenant_name   = lookup(var.settings, "tenant_name", data.azuread_domains.aad_domains.domains[0].domain_name)
  keyvault_id   = var.keyvaults[var.client_config.landingzone_key][var.settings.keyvault_key].id
  secret_prefix = lookup(var.settings, "secret_prefix", "")

  # Global settings can be overwritten
  prefix = lookup(var.settings, "useprefix", null) == true ? var.global_settings.prefix : []

}