# # TODO

# resource "azurerm_backup_container_storage_account" "container" {
#   resource_group_name = azurerm_resource_group.rg.name
#   recovery_vault_name = azurerm_recovery_services_vault.vault.name
#   storage_account_id  = azurerm_storage_account.sa.id
# }

# resource "azurerm_backup_protected_file_share" "share1" {
#   resource_group_name       = azurerm_resource_group.rg.name
#   recovery_vault_name       = azurerm_recovery_services_vault.vault.name
#   source_storage_account_id = azurerm_backup_container_storage_account.protection-container.storage_account_id
#   source_file_share_name    = azurerm_storage_share.example.name
#   backup_policy_id          = azurerm_backup_policy_file_share.example.id
# }

# resource "azurerm_backup_protected_vm" "vm1" {
#   resource_group_name = azurerm_resource_group.example.name
#   recovery_vault_name = azurerm_recovery_services_vault.example.name
#   source_vm_id        = azurerm_virtual_machine.example.id
#   backup_policy_id    = azurerm_backup_policy_vm.example.id
# }