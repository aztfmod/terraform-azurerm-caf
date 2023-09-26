locals {
  keyvault = local.create_sshkeys || local.os_type == "windows" ? var.keyvaults[try(var.settings.keyvault.lz_key, var.settings.lz_key, var.client_config.landingzone_key)][try(var.settings.keyvault.key, var.settings.keyvault_key)] : null
}
