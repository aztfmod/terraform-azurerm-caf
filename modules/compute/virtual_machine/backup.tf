resource "azurerm_backup_protected_vm" "backup" {
  count = try(var.settings.backup, null) == null ? 0 : 1

  resource_group_name = coalesce(
    try(var.recovery_vaults.resource_group_name, null),
    try(var.settings.backup.backup_vault_rg , null),
    try(split("/", var.settings.backup.backup_vault_id)[4], null)
  )
  recovery_vault_name = coalesce(
    try(var.recovery_vaults.name , null),
    try(var.settings.backup.backup_vault_name, null),
    try(split("/", var.settings.backup.backup_vault_id)[8], null)
  ) 
  source_vm_id = local.os_type == "linux" ? try(azurerm_linux_virtual_machine.vm["linux"].id, null) : try(azurerm_windows_virtual_machine.vm["windows"].id, null)
  backup_policy_id  = coalesce(
    try(var.recovery_vaults.backup_policies.virtual_machines[var.settings.backup.policy_key].id , null),
    try(var.settings.backup.backup_policy_id, null)
  )
  exclude_disk_luns = try(var.settings.backup.exclude_disk_luns , null)
  include_disk_luns = try(var.settings.backup.include_disk_luns , null)
  protection_state  = try(var.settings.backup.protection_state  , null)
}