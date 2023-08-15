locals {
  keyvault = local.create_sshkeys || local.os_type == "windows" ? try(var.keyvaults[var.settings.lz_key][var.settings.keyvault_key], var.keyvaults[var.client_config.landingzone_key][var.settings.keyvault_key]) : null
}
