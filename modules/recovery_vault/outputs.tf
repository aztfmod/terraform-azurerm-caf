
output "id" {
  description = "Output the object ID"
  value       = azurerm_recovery_services_vault.asr_rg_vault.id
}

output "name" {
  description = "Output the object name"
  value       = azurerm_recovery_services_vault.asr_rg_vault.name
}

output "backup_policies" {
  description = "Output the set of backup policies in this vault"
  value       = {
    virtual_machines = azurerm_backup_policy_vm.vm
    file_shares = azurerm_backup_policy_file_share.fs
  }
  
}

output "replication_policies" {
  description = "Ouput the set of replication policies in the vault"
  value       = azurerm_site_recovery_replication_policy.policy
}

output "resource_group_name" {
  description = "Output the object ID"
  value       = var.resource_group_name
}
