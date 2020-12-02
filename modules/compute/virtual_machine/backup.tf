locals {
  recovery_vault = try(var.settings.backup, null) == null ? null : try(var.recovery_vaults[var.client_config.landingzone_key][var.settings.backup.vault_key], var.recovery_vaults[var.settings.backup.lz_key][var.settings.backup.vault_key])
  source_vm_id   = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].id, null) : try(azurerm_windows_virtual_machine.vm["windows"].id, null)
}

resource "azurerm_backup_protected_vm" "backup" {
  count = try(var.settings.backup, null) == null ? 0 : 1

  resource_group_name = local.recovery_vault.resource_group_name
  recovery_vault_name = local.recovery_vault.name
  source_vm_id        = local.source_vm_id
  backup_policy_id    = local.recovery_vault.backup_policies.virtual_machines[var.settings.backup.policy_key].id
  # tags                = local.tags      # Commented - forcing a plan to create some diff as the tag is not handled properly in 2.37.0
}
