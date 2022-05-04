resource "azurerm_data_protection_backup_instance_disk" "backup_vault_instance" {
  name                         = var.settings.instance_name
  location                     = var.location
  vault_id                     = var.vault_id
  disk_id                      = var.disk_id
  snapshot_resource_group_name = var.snapshot_resource_group_name
  backup_policy_id             = var.backup_policy_id
}
